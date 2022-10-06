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
        
        clockControl.addTarget(self, action: #selector(SettingsVC.clockControlChanged(_:)), for: .valueChanged)
        temperatureUnitsControl.addTarget(self, action: #selector(SettingsVC.temperatureUnitsControlChanged(_:)), for: .valueChanged)
        windUnitsControl.addTarget(self, action: #selector(SettingsVC.windUnitsControlChanged(_:)), for: .valueChanged)
        pressureUnitsControl.addTarget(self, action: #selector(SettingsVC.pressureUnitsControlChanged(_:)), for: .valueChanged)
        recommendationsControl.addTarget(self, action: #selector(SettingsVC.recommendationsControlChanged(_:)), for: .valueChanged)
        
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
        
        if defaults.string(forKey: "recommendations") == "on" {
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
    
    func changeDefaultColor(number: Int, color: String) {
        settingsChanged = true
        
        defaults.set(number, forKey: "color")
        themeLabel.text = color
        print("color set to: \(color)(\(defaults.string(forKey: "color") ?? ""))")
    }
    
    func changeSegmentControl(control: UISegmentedControl, settingValue0: String, settingValue1: String, settingKey: String) {
        settingsChanged = true
        
        if control.selectedSegmentIndex == 0 {
            defaults.set(settingValue0, forKey: settingKey)
        } else if control.selectedSegmentIndex == 1 {
            defaults.set(settingValue1, forKey: settingKey)
        }
        
        print("\(settingKey) set to: \(defaults.string(forKey: settingKey) ?? "")")
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
    
    @objc func clockControlChanged(_ sender: UISegmentedControl) {
        changeSegmentControl(control: clockControl, settingValue0: "12h", settingValue1: "24h", settingKey: "clock")
    }
    
    @objc func temperatureUnitsControlChanged(_ sender: UISegmentedControl) {
        changeSegmentControl(control: temperatureUnitsControl, settingValue0: "F", settingValue1: "C", settingKey: "temperatureUnits")
    }
    
    @objc func windUnitsControlChanged(_ sender: UISegmentedControl) {
        changeSegmentControl(control: windUnitsControl, settingValue0: "mph", settingValue1: "km/h", settingKey: "windUnits")
    }
    
    @objc func pressureUnitsControlChanged(_ sender: UISegmentedControl) {
        changeSegmentControl(control: pressureUnitsControl, settingValue0: "inHg", settingValue1: "mmHg", settingKey: "pressureUnits")
    }
    
    @objc func recommendationsControlChanged(_ sender: UISegmentedControl) {
        changeSegmentControl(control: recommendationsControl, settingValue0: "on", settingValue1: "off", settingKey: "recommendations")
    }
    
    @IBAction func themeButton0Tapped(_ sender: UIButton) {
        changeDefaultColor(number: 0, color: "light orange")
    }
    
    @IBAction func themeButton1Tapped(_ sender: UIButton) {
        changeDefaultColor(number: 1, color: "pollen")
    }
    
    @IBAction func themeButton2Tapped(_ sender: UIButton) {
        changeDefaultColor(number: 2, color: "mint")
    }
    
    @IBAction func themeButton3Tapped(_ sender: UIButton) {
        changeDefaultColor(number: 3, color: "lilac")
    }
    
    @IBAction func themeButton4Tapped(_ sender: UIButton) {
        changeDefaultColor(number: 4, color: "azure")
    }
    
    @IBAction func themeButton5Tapped(_ sender: UIButton) {
        changeDefaultColor(number: 5, color: "midnight blue")
    }
    
    @IBAction func themeButton6Tapped(_ sender: UIButton) {
        changeDefaultColor(number: 6, color: "ultra violet")
    }
    
    @IBAction func themeButton7Tapped(_ sender: UIButton) {
        changeDefaultColor(number: 7, color: "rose red")
    }
    
    @IBAction func themeButton8Tapped(_ sender: UIButton) {
        changeDefaultColor(number: 8, color: "antique white")
    }
    
    @IBAction func themeButton9Tapped(_ sender: UIButton) {
        changeDefaultColor(number: 9, color: "dark olive")
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
