//
//  LocationsVC.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 10/10/22.
//

import UIKit

class LocationsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var locationsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationsTable?.delegate = self
        locationsTable?.dataSource = self
        userSelectedLocation = false
        
        print(locationsArray)
        //print(defaults.array(forKey: "savedLocations") ?? locationsArray)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = locationsArray[indexPath.row].name

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        userSelectedLocation = true
        userSelectedLocationRow = indexPath.row
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "ForecastVC") as! ForecastVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
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
