//
//  LocationsVC.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 10/10/22.
//

import UIKit
import MapKit

class SearchLocationsVC: UIViewController, MKLocalSearchCompleterDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultsTable: UITableView!

    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchCompleter.delegate = self
        searchBar?.delegate = self
        searchResultsTable?.delegate = self
        searchResultsTable?.dataSource = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchResultsTable.reloadData()
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("search error")
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "LocationsVC") as! LocationsVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

extension SearchLocationsVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle

        return cell
    }
}

extension SearchLocationsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let result = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: result)

        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let coordinate = response?.mapItems[0].placemark.coordinate else {
                return
            }

            guard let name = response?.mapItems[0].name else {
                return
            }

            let lat = coordinate.latitude
            let lon = coordinate.longitude
            
            locationsArray.append(Location(latitude: lat, longitude: lon, name: name))
            //defaults.set(locationsArray, forKey: "savedLocations")
        }
    }
}
