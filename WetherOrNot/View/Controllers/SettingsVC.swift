//
//  SettingsVC.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 9/9/22.
//

import UIKit

class SettingsVC: UITableViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Settings"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        dropletTipButton.layer.cornerRadius = CGFloat(GlobalVariables.sharedInstance.cornerRadius)
        drizzleTipButton.layer.cornerRadius = CGFloat(GlobalVariables.sharedInstance.cornerRadius)
        showerTipButton.layer.cornerRadius = CGFloat(GlobalVariables.sharedInstance.cornerRadius)
        downpourTipButton.layer.cornerRadius = CGFloat(GlobalVariables.sharedInstance.cornerRadius)
    }
    
    @IBAction func themeButton0Tapped(_ sender: UIButton) {
        defaults.set(0, forKey: "color")
    }
    
    @IBAction func themeButton1Tapped(_ sender: UIButton) {
        defaults.set(1, forKey: "color")
    }
    
    @IBAction func themeButton2Tapped(_ sender: UIButton) {
        defaults.set(2, forKey: "color")
    }
    
    @IBAction func themeButton3Tapped(_ sender: UIButton) {
        defaults.set(3, forKey: "color")
    }
    
    @IBAction func themeButton4Tapped(_ sender: UIButton) {
        defaults.set(4, forKey: "color")
    }
    
    @IBAction func themeButton5Tapped(_ sender: UIButton) {
        defaults.set(5, forKey: "color")
    }
    
    @IBAction func themeButton6Tapped(_ sender: UIButton) {
        defaults.set(6, forKey: "color")
    }
    
    @IBAction func themeButton7Tapped(_ sender: UIButton) {
        defaults.set(7, forKey: "color")
    }
    
    @IBAction func themeButton8Tapped(_ sender: UIButton) {
        defaults.set(8, forKey: "color")
    }
    
    @IBAction func themeButton9Tapped(_ sender: UIButton) {
        defaults.set(9, forKey: "color")
    }
    
    @IBAction func dropletTipButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func drizzleTipButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func showerTipButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func downpourTipButtonTapped(_ sender: UIButton) {
    }
}
