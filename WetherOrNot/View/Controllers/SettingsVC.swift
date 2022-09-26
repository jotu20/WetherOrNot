//
//  SettingsVC.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 9/9/22.
//

import UIKit
import StoreKit

class SettingsVC: UITableViewController {

    @IBOutlet weak var clockControl: UISegmentedControl!
    @IBOutlet weak var temperatureUnitsControl: UISegmentedControl!
    @IBOutlet weak var windUnitsControl: UISegmentedControl!
    @IBOutlet weak var pressureUnitsControl: UISegmentedControl!
    
    @IBOutlet weak var dropletTipButton: UIButton!
    @IBOutlet weak var drizzleTipButton: UIButton!
    @IBOutlet weak var showerTipButton: UIButton!
    @IBOutlet weak var downpourTipButton: UIButton!
    
    @IBOutlet weak var themeButton0: UIButton!
    @IBOutlet weak var themeButton1: UIButton!
    @IBOutlet weak var themeButton2: UIButton!
    @IBOutlet weak var themeButton3: UIButton!
    @IBOutlet weak var themeButton4: UIButton!
    @IBOutlet weak var themeButton5: UIButton!
    @IBOutlet weak var themeButton6: UIButton!
    @IBOutlet weak var themeButton7: UIButton!
    @IBOutlet weak var themeButton8: UIButton!
    @IBOutlet weak var themeButton9: UIButton!
    
    var productsArray = [SKProduct]()
    var settingsChanged: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Settings"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = .label
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        dropletTipButton.layer.cornerRadius = CGFloat(GlobalVariables.sharedInstance.cornerRadius)
        drizzleTipButton.layer.cornerRadius = CGFloat(GlobalVariables.sharedInstance.cornerRadius)
        showerTipButton.layer.cornerRadius = CGFloat(GlobalVariables.sharedInstance.cornerRadius)
        downpourTipButton.layer.cornerRadius = CGFloat(GlobalVariables.sharedInstance.cornerRadius)
        
        ProductIAPHandler.shared.setProductIds(ids: ["com.dropletTip", "com.drizzleTip", "com.showerTip", "com.downpourTip"])
        ProductIAPHandler.shared.fetchAvailableProducts { [weak self] (products) in
            self?.productsArray = products
         }
        
        if defaults.string(forKey: "clock") == "12h" {
            clockControl.selectedSegmentIndex = 0
        } else {
            clockControl.selectedSegmentIndex = 1
        }
        
        if defaults.string(forKey: "temperatureUnits") == "F" {
            temperatureUnitsControl.selectedSegmentIndex = 0
        } else {
            temperatureUnitsControl.selectedSegmentIndex = 1
        }
        
        if defaults.string(forKey: "windUnits") == "mph" {
            windUnitsControl.selectedSegmentIndex = 0
        } else {
            windUnitsControl.selectedSegmentIndex = 1
        }
        
        if defaults.string(forKey: "pressureUnits") == "inHg" {
            pressureUnitsControl.selectedSegmentIndex = 0
        } else {
            pressureUnitsControl.selectedSegmentIndex = 1
        }
        
        settingsChanged = false
    }
    
    @objc func doneTapped(sender: UIBarButtonItem) {
        if settingsChanged == true {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "ForecastVC") as! ForecastVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        } else {
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func clockControlTapped(_ sender: UISegmentedControl) {
        settingsChanged = true
        
        if clockControl.isEnabledForSegment(at: 0) {
            clockControl.selectedSegmentIndex = 1
            defaults.set("24h", forKey: "clock")
        } else {
            clockControl.selectedSegmentIndex = 0
            defaults.set("12h", forKey: "clock")
        }
    }
    
    @IBAction func temperatureUnitsControlTapped(_ sender: UISegmentedControl) {
        settingsChanged = true
        
        if temperatureUnitsControl.isEnabledForSegment(at: 0) {
            temperatureUnitsControl.selectedSegmentIndex = 1
            defaults.set("C", forKey: "temperatureUnits")
        } else {
            temperatureUnitsControl.selectedSegmentIndex = 0
            defaults.set("F", forKey: "temperatureUnits")
        }
    }
    
    @IBAction func windUnitsControlTapped(_ sender: UISegmentedControl) {
        settingsChanged = true
        
        if windUnitsControl.isEnabledForSegment(at: 0) {
            windUnitsControl.selectedSegmentIndex = 1
            defaults.set("km/h", forKey: "windUnits")
        } else {
            windUnitsControl.selectedSegmentIndex = 0
            defaults.set("mph", forKey: "windUnits")
        }
    }
    
    @IBAction func pressureUnitsControlTapped(_ sender: UISegmentedControl) {
        settingsChanged = true
        
        if pressureUnitsControl.isEnabledForSegment(at: 0) {
            pressureUnitsControl.selectedSegmentIndex = 1
            defaults.set("inHg", forKey: "pressureUnits")
        } else {
            pressureUnitsControl.selectedSegmentIndex = 0
            defaults.set("mmHg", forKey: "pressureUnits")
        }
    }
    
    @IBAction func themeButton0Tapped(_ sender: UIButton) {
        defaults.set(0, forKey: "color")
        settingsChanged = true
    }
    
    @IBAction func themeButton1Tapped(_ sender: UIButton) {
        settingsChanged = true
        defaults.set(1, forKey: "color")
    }
    
    @IBAction func themeButton2Tapped(_ sender: UIButton) {
        settingsChanged = true
        defaults.set(2, forKey: "color")
    }
    
    @IBAction func themeButton3Tapped(_ sender: UIButton) {
        settingsChanged = true
        defaults.set(3, forKey: "color")
    }
    
    @IBAction func themeButton4Tapped(_ sender: UIButton) {
        settingsChanged = true
        defaults.set(4, forKey: "color")
    }
    
    @IBAction func themeButton5Tapped(_ sender: UIButton) {
        settingsChanged = true
        defaults.set(5, forKey: "color")
    }
    
    @IBAction func themeButton6Tapped(_ sender: UIButton) {
        settingsChanged = true
        defaults.set(6, forKey: "color")
    }
    
    @IBAction func themeButton7Tapped(_ sender: UIButton) {
        settingsChanged = true
        defaults.set(7, forKey: "color")
    }
    
    @IBAction func themeButton8Tapped(_ sender: UIButton) {
        settingsChanged = true
        defaults.set(8, forKey: "color")
    }
    
    @IBAction func themeButton9Tapped(_ sender: UIButton) {
        settingsChanged = true
        defaults.set(9, forKey: "color")
    }
    
    @IBAction func dropletTipButtonTapped(_ sender: UIButton) {
        ProductIAPHandler.shared.purchase(product: self.productsArray[2]) { (alert, product, transaction) in
           if let tran = transaction, let prod = product {
               print(tran, prod)
               
               if tran.transactionState == .purchased {
                   let alert = UIAlertController(title: "Thank you!", message: "Your purchase is much appreciated and helps fund the services for this app.", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "Done", style: .default))
                   self.present(alert, animated: true)
               } else {
                   let alert = UIAlertController(title: "", message: "Looks like someting went wrong!", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default))
                   self.present(alert, animated: true)
               }
           }
        }
    }
    
    @IBAction func drizzleTipButtonTapped(_ sender: UIButton) {
        ProductIAPHandler.shared.purchase(product: self.productsArray[1]) { (alert, product, transaction) in
           if let tran = transaction, let prod = product {
               print(tran, prod)
               
               if tran.transactionState == .purchased {
                   let alert = UIAlertController(title: "Thank you!", message: "Your purchase is much appreciated and helps fund the services for this app.", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "Done", style: .default))
                   self.present(alert, animated: true)
               } else {
                   let alert = UIAlertController(title: "", message: "Looks like someting went wrong!", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default))
                   self.present(alert, animated: true)
               }
           }
        }
    }
    
    @IBAction func showerTipButtonTapped(_ sender: UIButton) {
        ProductIAPHandler.shared.purchase(product: self.productsArray[3]) { (alert, product, transaction) in
           if let tran = transaction, let prod = product {
               print(tran, prod)
               
               if tran.transactionState == .purchased {
                   let alert = UIAlertController(title: "Thank you!", message: "Your purchase is much appreciated and helps fund the services for this app.", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "Done", style: .default))
                   self.present(alert, animated: true)
               } else {
                   let alert = UIAlertController(title: "", message: "Looks like someting went wrong!", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default))
                   self.present(alert, animated: true)
               }
           }
        }
    }
    
    @IBAction func downpourTipButtonTapped(_ sender: UIButton) {
        ProductIAPHandler.shared.purchase(product: self.productsArray[0]) { (alert, product, transaction) in
           if let tran = transaction, let prod = product {
               print(tran, prod)
               
               if tran.transactionState == .purchased {
                   let alert = UIAlertController(title: "Thank you!", message: "Your purchase is much appreciated and helps fund the services for this app.", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "Done", style: .default))
                   self.present(alert, animated: true)
               } else {
                   let alert = UIAlertController(title: "", message: "Looks like someting went wrong!", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default))
                   self.present(alert, animated: true)
               }
           }
        }
    }
}
