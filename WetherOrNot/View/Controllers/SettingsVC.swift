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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Settings"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        dropletTipButton.layer.cornerRadius = 10
        drizzleTipButton.layer.cornerRadius = 10
        showerTipButton.layer.cornerRadius = 10
        downpourTipButton.layer.cornerRadius = 10
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
