//
//  ProductIAPHandler.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 9/23/22.
//

import Foundation
import StoreKit

enum ProductIAPHandlerAlertType {
    case setProductIds
    case disabled
    case restored
    case purchased
    
    var message: String {
        switch self {
            case .setProductIds: return "Product ids not set, call setProductIds method!"
            case .disabled: return "Purchases are disabled on your device!"
            case .restored: return "You've successfully restored your purchase!"
            case .purchased: return "You've successfully bought this purchase!"
        }
    }
}

class ProductIAPHandler: NSObject {
    static let shared = ProductIAPHandler()
    private override init() { }
    
    fileprivate var productIds = [String]()
    fileprivate var productID = ""
    fileprivate var productsRequest = SKProductsRequest()
    fileprivate var fetchProductCompletion: (([SKProduct])->Void)?
    
    fileprivate var productToPurchase: SKProduct?
    fileprivate var purchaseProductCompletion: ((ProductIAPHandlerAlertType, SKProduct?, SKPaymentTransaction?)->Void)?
    
    var isLogEnabled: Bool = true
    
    func setProductIds(ids: [String]) {
        self.productIds = ids
    }

    func canMakePurchases() -> Bool { return SKPaymentQueue.canMakePayments() }
    
    func purchase(product: SKProduct, completion: @escaping ((ProductIAPHandlerAlertType, SKProduct?, SKPaymentTransaction?)->Void)) {
        self.purchaseProductCompletion = completion
        self.productToPurchase = product

        if self.canMakePurchases() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
            
            log("PRODUCT TO PURCHASE: \(product.productIdentifier)")
            productID = product.productIdentifier
        } else {
            completion(ProductIAPHandlerAlertType.disabled, nil, nil)
        }
    }
    
    func restorePurchase() {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func fetchAvailableProducts(completion: @escaping (([SKProduct])->Void)){
        self.fetchProductCompletion = completion
        
        if self.productIds.isEmpty {
            log(ProductIAPHandlerAlertType.setProductIds.message)
            fatalError(ProductIAPHandlerAlertType.setProductIds.message)
        } else {
            productsRequest = SKProductsRequest(productIdentifiers: Set(self.productIds))
            productsRequest.delegate = self
            productsRequest.start()
        }
    }
    
    fileprivate func log <T> (_ object: T) {
        if isLogEnabled {
            NSLog("\(object)")
        }
    }
}

extension ProductIAPHandler: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    func productsRequest (_ request:SKProductsRequest, didReceive response:SKProductsResponse) {
        if (response.products.count > 0) {
            if let completion = self.fetchProductCompletion {
                completion(response.products)
            }
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        if let completion = self.purchaseProductCompletion {
            completion(ProductIAPHandlerAlertType.restored, nil, nil)
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions {
            if let trans = transaction as? SKPaymentTransaction {
                switch trans.transactionState {
                case .purchased:
                    log("Product purchase done")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    if let completion = self.purchaseProductCompletion {
                        completion(ProductIAPHandlerAlertType.purchased, self.productToPurchase, trans)
                    }
                    break
                    
                case .failed:
                    log("Product purchase failed")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                case .restored:
                    log("Product restored")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                    
                default: break
                }}}
    }
}
