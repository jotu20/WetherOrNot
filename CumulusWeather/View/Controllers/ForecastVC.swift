//
//  ViewController.swift
//  CumulusWeather
//
//  Created by Joseph Szafarowicz on 7/18/22.
//

import UIKit
import CoreLocation

class ForecastVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var currentCardView: CurrentCardView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var currentAlertsStackView: UIStackView!
    
    @IBOutlet weak var conditionLabel0: UILabel!
    @IBOutlet weak var conditionLabel1: UILabel!
    @IBOutlet weak var conditionLabel2: UILabel!
    @IBOutlet weak var conditionLabel3: UILabel!
    @IBOutlet weak var conditionLabel4: UILabel!
    @IBOutlet weak var conditionLabel5: UILabel!
    
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
    
    let locationManager = CLLocationManager()
    var fetcher = FetchWeather()
    var refreshControl: UIRefreshControl!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setColor(view: mainView, value: defaults.integer(forKey: "color"))
        getWeatherService()
        
        let locationTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.locationLabelTapped(_:)))
        self.locationNameLabel.addGestureRecognizer(locationTapGesture)

        let alertTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.alertLabelTapped(_:)))
        self.alertLabel.addGestureRecognizer(alertTapGesture)

        if CurrentAlerts.sharedInstance.isEmpty == false {
            currentAlertsStackView.isHidden = false
        } else {
            currentAlertsStackView.isHidden = true
        }
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if forecastLoaded == false || settingsChanged == true || userSelectedLocation == true {
            createSpinnerView()
        }
    }
    
    func getWeatherService() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            if userSelectedLocation == true && userSelectedLocationRow > 0 {
                self.locationNameLabel.text = locationsArray[userSelectedLocationRow].name
                
                defaults.set(locationsArray[userSelectedLocationRow].name, forKey: "savedLocationName")
                defaults.set(locationsArray[userSelectedLocationRow].latitude, forKey: "savedLocationLatitude")
                defaults.set(locationsArray[userSelectedLocationRow].longitude, forKey: "savedLocationLongitude")
                
                DispatchQueue.main.async {
                    Task {
                        await self.fetcher.fetch(vc: ForecastVC(),latitude: locationsArray[userSelectedLocationRow].latitude, longitude: locationsArray[userSelectedLocationRow].longitude)
                        
                        setupCurrentCard(view: self.currentCardView)
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
        
        if defaults.bool(forKey: "locationServicesEnabled") == false {
            self.locationNameLabel.text = defaults.string(forKey: "savedLocationName")
            
            DispatchQueue.main.async {
                Task {
                    await self.fetcher.fetch(vc: ForecastVC(),latitude: defaults.double(forKey: "savedLocationLatitude"), longitude: defaults.double(forKey: "savedLocationLongitude"))
                    
                    setupCurrentCard(view: self.currentCardView)
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
                    
                    let uvIndex = CurrentForecast.sharedInstance.uvIndex
                    if uvIndex <= 2 {
                        self.conditionLabel4.text = "Low (\(uvIndex))"
                    } else if uvIndex >= 3 && uvIndex <= 5 {
                        self.conditionLabel4.text = "Moderate (\(uvIndex))"
                    } else if uvIndex >= 6 && uvIndex <= 7 {
                        self.conditionLabel4.text = "High (\(uvIndex))"
                    } else if uvIndex >= 8 && uvIndex <= 10 {
                        self.conditionLabel4.text = "Very high (\(uvIndex))"
                    } else if uvIndex >= 11 {
                        self.conditionLabel4.text = "Extreme (\(uvIndex))"
                    }
                    
                    let humidity = Int(CurrentForecast.sharedInstance.humidity * 100)
                    if humidity < 25 {
                        self.conditionLabel0.text = "Low (\(humidity)%)"
                    } else if humidity >= 25 && humidity < 70 {
                        self.conditionLabel0.text = "Fair (\(humidity)%)"
                    } else if humidity >= 70 {
                        self.conditionLabel0.text = "High (\(humidity)%)"
                    }
                    
                    let windSpeed = CurrentForecast.sharedInstance.windSpeed.rounded()
                    let windDirection = CurrentForecast.sharedInstance.windDirection
                    let windGust = CurrentForecast.sharedInstance.windGust.rounded()
                    let windUnits = defaults.string(forKey: "windUnits") ?? ""
                    self.conditionLabel3.text = "\(Int(windSpeed))(\(Int(windGust)))\(windUnits) \(windDirection)"
                    
                    let pressure = Int(CurrentForecast.sharedInstance.pressure)
                    let pressureUnits = defaults.string(forKey: "pressureUnits") ?? ""
                    self.conditionLabel1.text = "\(pressure)\(pressureUnits)"
                    
                    self.conditionLabel3.text = CurrentForecast.sharedInstance.sunrise
                    self.conditionLabel5.text = CurrentForecast.sharedInstance.sunset

                    setupCurrentCard(view: self.currentCardView)
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
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            defaults.set(true, forKey: "locationServicesEnabled")
        } else if status == .denied {
            defaults.set(false, forKey: "locationServicesEnabled")
            if defaults.double(forKey: "savedLocationLatitude") == 0 && defaults.double(forKey: "savedLocationLongitude") ==  0 {
                let vc = self.storyboard!.instantiateViewController(withIdentifier: "SavedLocationsVC") as! SavedLocationsVC
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
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
        setColor(view: child.view, value: defaults.integer(forKey: "color"))
        view.addSubview(child.view)
        child.didMove(toParent: self)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
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

