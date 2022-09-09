//
//  ViewController.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 7/18/22.
//

import UIKit
import CoreLocation

class ForecastVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var currentCardView: CurrentCardView!
    @IBOutlet weak var day0CardView: DayCardView!
    @IBOutlet weak var day1CardView: DayCardView!
    @IBOutlet weak var day2CardView: DayCardView!
    @IBOutlet weak var day3CardView: DayCardView!
    @IBOutlet weak var day4CardView: DayCardView!

    @IBOutlet weak var settingsButton: UIButton!
    
    let locationManager = CLLocationManager()
    var fetcher = FetchWeather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print("User location found.", latitude, longitude)
            
            DispatchQueue.main.async {
                self.locationManager.stopUpdatingLocation()
//                self.fetcher.fetchDaily(latitude: latitude, longitude: longitude)
//
//                setupCurrentCard(view: self.currentCardView)
//                setupDayCard(view: self.day0CardView, dayNumber: 0, data: self.fetcher)
//                setupDayCard(view: self.day1CardView, dayNumber: 1, data: self.fetcher)
//                setupDayCard(view: self.day2CardView, dayNumber: 2, data: self.fetcher)
//                setupDayCard(view: self.day3CardView, dayNumber: 3, data: self.fetcher)
//                setupDayCard(view: self.day4CardView, dayNumber: 4, data: self.fetcher)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("User location not found.")
    }
    
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
//        let vc = SettingsVC()
//        self.present(vc, animated: true, completion: nil)
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated: true, completion: nil)
    }

}

