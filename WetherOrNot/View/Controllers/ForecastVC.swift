//
//  ViewController.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 7/18/22.
//

import UIKit
import CoreLocation

class ForecastVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var currentAlertsStackView: UIStackView!
    
    @IBOutlet weak var currentCardView: CurrentCardView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var currentSubheadCardView0: CurrentSubheadCardView!
    @IBOutlet weak var currentSubheadCardView1: CurrentSubheadCardView!
    @IBOutlet weak var currentSubheadCardView2: CurrentSubheadCardView!
    @IBOutlet weak var currentSubheadCardView3: CurrentSubheadCardView!
    
    @IBOutlet weak var day0CardView: DayCardView!
    @IBOutlet weak var day1CardView: DayCardView!
    @IBOutlet weak var day2CardView: DayCardView!
    @IBOutlet weak var day3CardView: DayCardView!
    @IBOutlet weak var day4CardView: DayCardView!
    @IBOutlet weak var day5CardView: DayCardView!
    @IBOutlet weak var day6CardView: DayCardView!
    @IBOutlet weak var day7CardView: DayCardView!
    @IBOutlet weak var day8CardView: DayCardView!
    @IBOutlet weak var day9CardView: DayCardView!
    
    @IBOutlet weak var currentSubheadCardConstraintTop: NSLayoutConstraint!
    
    let locationManager = CLLocationManager()
    var fetcher = FetchWeather()
    var refreshControl: UIRefreshControl!
    
    override func viewWillAppear(_ animated: Bool) {
        getWeatherService()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if forecastLoaded == false || settingsChanged == true {
            createSpinnerView()
        }
        
        let locationTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.locationLabelTapped(_:)))
        self.locationNameLabel.addGestureRecognizer(locationTapGesture)
        
        let alertTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.alertLabelTapped(_:)))
        self.alertLabel.addGestureRecognizer(alertTapGesture)
        
        if CurrentAlerts.sharedInstance.isEmpty == false {
            currentAlertsStackView.isHidden = false
        } else {
            currentAlertsStackView.isHidden = true
        }
        
        if defaults.string(forKey: "recommendations") == "off" {
            descriptionLabel.isHidden = true
            currentSubheadCardConstraintTop.constant = -20
        } else {
            descriptionLabel.isHidden = false
            currentSubheadCardConstraintTop.constant = 40
        }
    }
    
    func getWeatherService() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            if userSelectedLocation == true && userSelectedLocationRow > 0 {
                self.locationNameLabel.text = locationsArray[userSelectedLocationRow].name
                
                DispatchQueue.main.async {
                    Task {
                        await self.fetcher.fetch(vc: ForecastVC(),latitude: locationsArray[userSelectedLocationRow].latitude, longitude: locationsArray[userSelectedLocationRow].longitude)
                        
                        setupCurrentCard(view: self.currentCardView)
                        setupCurrentSubheadCard(view: self.currentSubheadCardView0, type: "Wind")
                        setupCurrentSubheadCard(view: self.currentSubheadCardView1, type: "UV Index")
                        setupCurrentSubheadCard(view: self.currentSubheadCardView2, type: "Humidity")
                        setupCurrentSubheadCard(view: self.currentSubheadCardView3, type: "Pressure")
                        self.descriptionLabel.text = GlobalVariables.sharedInstance.description
                        
                        setupDayCard(view: self.day0CardView, dayNumber: 0, data: self.fetcher)
                        setupDayCard(view: self.day1CardView, dayNumber: 1, data: self.fetcher)
                        setupDayCard(view: self.day2CardView, dayNumber: 2, data: self.fetcher)
                        setupDayCard(view: self.day3CardView, dayNumber: 3, data: self.fetcher)
                        setupDayCard(view: self.day4CardView, dayNumber: 4, data: self.fetcher)
                        setupDayCard(view: self.day5CardView, dayNumber: 5, data: self.fetcher)
                        setupDayCard(view: self.day6CardView, dayNumber: 6, data: self.fetcher)
                        setupDayCard(view: self.day7CardView, dayNumber: 7, data: self.fetcher)
                        setupDayCard(view: self.day8CardView, dayNumber: 8, data: self.fetcher)
                        setupDayCard(view: self.day9CardView, dayNumber: 9, data: self.fetcher)
                    }
                }
            } else {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            GlobalVariables.sharedInstance.latitude = location.coordinate.latitude
            GlobalVariables.sharedInstance.longitude = location.coordinate.longitude
            print("User location found")
            
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: GlobalVariables.sharedInstance.latitude, longitude: GlobalVariables.sharedInstance.longitude)
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
                    await self.fetcher.fetch(vc: ForecastVC(),latitude: GlobalVariables.sharedInstance.latitude, longitude: GlobalVariables.sharedInstance.longitude)

                    setupCurrentCard(view: self.currentCardView)
                    setupCurrentSubheadCard(view: self.currentSubheadCardView0, type: "Wind")
                    setupCurrentSubheadCard(view: self.currentSubheadCardView1, type: "UV Index")
                    setupCurrentSubheadCard(view: self.currentSubheadCardView2, type: "Humidity")
                    setupCurrentSubheadCard(view: self.currentSubheadCardView3, type: "Pressure")
                    self.descriptionLabel.text = GlobalVariables.sharedInstance.description

                    setupDayCard(view: self.day0CardView, dayNumber: 0, data: self.fetcher)
                    setupDayCard(view: self.day1CardView, dayNumber: 1, data: self.fetcher)
                    setupDayCard(view: self.day2CardView, dayNumber: 2, data: self.fetcher)
                    setupDayCard(view: self.day3CardView, dayNumber: 3, data: self.fetcher)
                    setupDayCard(view: self.day4CardView, dayNumber: 4, data: self.fetcher)
                    setupDayCard(view: self.day5CardView, dayNumber: 5, data: self.fetcher)
                    setupDayCard(view: self.day6CardView, dayNumber: 6, data: self.fetcher)
                    setupDayCard(view: self.day7CardView, dayNumber: 7, data: self.fetcher)
                    setupDayCard(view: self.day8CardView, dayNumber: 8, data: self.fetcher)
                    setupDayCard(view: self.day9CardView, dayNumber: 9, data: self.fetcher)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("User location not found")
    }
    
    func createSpinnerView() {
        let child = SpinnerViewController()

        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    
    @objc func locationLabelTapped(_ sender: UITapGestureRecognizer) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "SavedLocationsVC") as! SavedLocationsVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func alertLabelTapped(_ sender: UITapGestureRecognizer) {
        let alert = CurrentAlerts.sharedInstance.detailsURL
        if alert.isEmpty == false {
            if let url = URL(string: alert) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    @objc func refresh() {
        print("refreshing...")
        self.getWeatherService()
        refreshControl.endRefreshing()
    }
    
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true)
    }
}

