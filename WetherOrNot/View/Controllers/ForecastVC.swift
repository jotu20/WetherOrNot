//
//  ViewController.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 7/18/22.
//

import UIKit
import CoreLocation

class ForecastVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var currentCardView: CurrentCardView!
    @IBOutlet weak var currentSubheadCardView0: CurrentSubheadCardView!
    @IBOutlet weak var currentSubheadCardView1: CurrentSubheadCardView!
    @IBOutlet weak var currentSubheadCardView2: CurrentSubheadCardView!
    @IBOutlet weak var currentSubheadCardView3: CurrentSubheadCardView!
    
    @IBOutlet weak var day0CardView: DayCardView!
    @IBOutlet weak var day1CardView: DayCardView!
    @IBOutlet weak var day2CardView: DayCardView!
    @IBOutlet weak var day3CardView: DayCardView!
    @IBOutlet weak var day4CardView: DayCardView!
    @IBOutlet weak var settingsButton: UIButton!
    
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
        createSpinnerView()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print("User location found.", latitude, longitude)
            
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: latitude, longitude: longitude)
            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in

                var placeMark: CLPlacemark!
                placeMark = placemarks?[0]
                
                if let locationName = placeMark.locality  {
                    self.locationNameLabel.text = locationName
                }
            })
            
            self.locationManager.stopUpdatingLocation()
            DispatchQueue.main.async {
                Task {
                    await self.fetcher.fetch(latitude: latitude, longitude: longitude)

                    setupCurrentCard(view: self.currentCardView)
                    setupCurrentSubheadCard(view: self.currentSubheadCardView0, type: "Wind")
                    setupCurrentSubheadCard(view: self.currentSubheadCardView1, type: "UV Index")
                    setupCurrentSubheadCard(view: self.currentSubheadCardView2, type: "Humidity")
                    setupCurrentSubheadCard(view: self.currentSubheadCardView3, type: "Pressure")
                    
                    setupDayCard(view: self.day0CardView, dayNumber: 0, data: self.fetcher)
                    setupDayCard(view: self.day1CardView, dayNumber: 1, data: self.fetcher)
                    setupDayCard(view: self.day2CardView, dayNumber: 2, data: self.fetcher)
                    setupDayCard(view: self.day3CardView, dayNumber: 3, data: self.fetcher)
                    setupDayCard(view: self.day4CardView, dayNumber: 4, data: self.fetcher)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("User location not found.")
    }
    
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated: true, completion: nil)
    }
    
    func createSpinnerView() {
        let child = SpinnerViewController()

        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }

}

