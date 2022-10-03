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
    @IBOutlet weak var recommendationsControl: UISegmentedControl!
    
    @IBOutlet weak var themeLabel: UILabel!
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
    
    @IBOutlet weak var dropletTipButton: UIButton!
    @IBOutlet weak var drizzleTipButton: UIButton!
    @IBOutlet weak var showerTipButton: UIButton!
    @IBOutlet weak var downpourTipButton: UIButton!
    
    @IBOutlet weak var versionLabel: UILabel!
    
    var productsArray = [SKProduct]()
    var settingsChanged: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Settings"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = .label
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        settingsChanged = false
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
        
        if defaults.string(forKey: "recommendations") == "off" {
            recommendationsControl.selectedSegmentIndex = 0
        } else {
            recommendationsControl.selectedSegmentIndex = 1
        }
        
        if defaults.integer(forKey: "color") == 0 {
            themeLabel.text = "light orange"
        } else if defaults.integer(forKey: "color") == 1 {
            themeLabel.text = "pollen"
        } else if defaults.integer(forKey: "color") == 2 {
            themeLabel.text = "mint"
        } else if defaults.integer(forKey: "color") == 3 {
            themeLabel.text = "lilac"
        } else if defaults.integer(forKey: "color") == 4 {
            themeLabel.text = "azure"
        } else if defaults.integer(forKey: "color") == 5 {
            themeLabel.text = "midnight blue"
        } else if defaults.integer(forKey: "color") == 6 {
            themeLabel.text = "ultra violet"
        } else if defaults.integer(forKey: "color") == 7 {
            themeLabel.text = "rose red"
        } else if defaults.integer(forKey: "color") == 8 {
            themeLabel.text = "antique white"
        } else if defaults.integer(forKey: "color") == 9 {
            themeLabel.text = "dark olive"
        }
        
        let appVersionShort = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let appVersionLong = Bundle.main.infoDictionary?["CFBundleString"] as? String
        versionLabel.text = "Version: \(appVersionShort ?? "0")(\(appVersionLong ?? "0"))"
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
        
        if clockControl.selectedSegmentIndex == 0 {
            clockControl.selectedSegmentIndex = 1
            defaults.set("24h", forKey: "clock")
        } else if clockControl.selectedSegmentIndex == 1 {
            clockControl.selectedSegmentIndex = 0
            defaults.set("12h", forKey: "clock")
        }
    }
    
    @IBAction func temperatureUnitsControlTapped(_ sender: UISegmentedControl) {
        settingsChanged = true
        
        if temperatureUnitsControl.selectedSegmentIndex == 0 {
            temperatureUnitsControl.selectedSegmentIndex = 1
            defaults.set("C", forKey: "temperatureUnits")
        } else if temperatureUnitsControl.selectedSegmentIndex == 1 {
            temperatureUnitsControl.selectedSegmentIndex = 0
            defaults.set("F", forKey: "temperatureUnits")
        }
    }
    
    @IBAction func windUnitsControlTapped(_ sender: UISegmentedControl) {
        settingsChanged = true
        
        if windUnitsControl.selectedSegmentIndex == 0 {
            windUnitsControl.selectedSegmentIndex = 1
            defaults.set("km/h", forKey: "windUnits")
        } else if windUnitsControl.selectedSegmentIndex == 1 {
            windUnitsControl.selectedSegmentIndex = 0
            defaults.set("mph", forKey: "windUnits")
        }
    }
    
    @IBAction func pressureUnitsControlTapped(_ sender: UISegmentedControl) {
        settingsChanged = true
        
        if pressureUnitsControl.selectedSegmentIndex == 0 {
            pressureUnitsControl.selectedSegmentIndex = 1
            defaults.set("mmHg", forKey: "pressureUnits")
        } else if pressureUnitsControl.selectedSegmentIndex == 1 {
            pressureUnitsControl.selectedSegmentIndex = 0
            defaults.set("inHg", forKey: "pressureUnits")
        }
    }
    
    @IBAction func recommendationsControlTapped(_ sender: UISegmentedControl) {
        settingsChanged = true
        
        if recommendationsControl.selectedSegmentIndex == 0 {
            recommendationsControl.selectedSegmentIndex = 1
            defaults.set("on", forKey: "recommendations")
        } else if recommendationsControl.selectedSegmentIndex == 1 {
            recommendationsControl.selectedSegmentIndex = 0
            defaults.set("off", forKey: "recommendations")
        }
    }
    
    @IBAction func themeButton0Tapped(_ sender: UIButton) {
        settingsChanged = true
        defaults.set(0, forKey: "color")
        themeLabel.text = "light orange"
    }
    
    @IBAction func themeButton1Tapped(_ sender: UIButton) {
        settingsChanged = true
        defaults.set(1, forKey: "color")
        themeLabel.text = "pollen"
    }
    
    @IBAction func themeButton2Tapped(_ sender: UIButton) {
        settingsChanged = true
        defaults.set(2, forKey: "color")
        themeLabel.text = "mint"
    }
    
    @IBAction func themeButton3Tapped(_ sender: UIButton) {
        settingsChanged = true
        defaults.set(3, forKey: "color")
        themeLabel.text = "lilac"
    }
    
    @IBAction func themeButton4Tapped(_ sender: UIButton) {
        settingsChanged = true
        defaults.set(4, forKey: "color")
        themeLabel.text = "azure"
    }
    
    @IBAction func themeButton5Tapped(_ sender: UIButton) {
        settingsChanged = true
        defaults.set(5, forKey: "color")
        themeLabel.text = "midnight blue"
    }
    
    @IBAction func themeButton6Tapped(_ sender: UIButton) {
        settingsChanged = true
        defaults.set(6, forKey: "color")
        themeLabel.text = "ultra violet"
    }
    
    @IBAction func themeButton7Tapped(_ sender: UIButton) {
        settingsChanged = true
        defaults.set(7, forKey: "color")
        themeLabel.text = "rose red"
    }
    
    @IBAction func themeButton8Tapped(_ sender: UIButton) {
        settingsChanged = true
        defaults.set(8, forKey: "color")
        themeLabel.text = "antique white"
    }
    
    @IBAction func themeButton9Tapped(_ sender: UIButton) {
        settingsChanged = true
        defaults.set(9, forKey: "color")
        themeLabel.text = "dark olive"
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
