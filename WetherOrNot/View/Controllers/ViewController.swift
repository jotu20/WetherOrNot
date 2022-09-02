//
//  ViewController.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 7/18/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var currentCardView: DayCardView!
    @IBOutlet weak var day0CardView: DayCardView!

    let locationManager = CLLocationManager()
    var fetcher = FetchWeather()
    
    override func viewWillAppear(_ animated: Bool) {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print("User location found.", latitude, longitude)
            
            DispatchQueue.main.async {
                Task {
                    await self.fetcher.fetchCurrent(latitude: latitude, longitude: longitude)
                    
                    setupDayCard(dayView: self.day0CardView, dayNumber: 0, data: self.fetcher)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("User location not found.")
    }

}

