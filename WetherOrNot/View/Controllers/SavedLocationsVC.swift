//
//  SavedLocationsVC.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 10/10/22.
//

import UIKit

class SavedLocationsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        self.present(vc, animated: false)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
       if indexPath.row == 0 {
           return UITableViewCell.EditingStyle.none
        } else {
            return UITableViewCell.EditingStyle.delete
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            locationsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "SearchLocationsVC") as! SearchLocationsVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "ForecastVC") as! ForecastVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
}
