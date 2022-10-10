//
//  LocationsVC.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 10/10/22.
//

import UIKit

class LocationsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "SearchLocationsVC") as! SearchLocationsVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func currentLocationButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
