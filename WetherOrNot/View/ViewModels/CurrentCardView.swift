//
//  CurrentCardView.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 9/1/22.
//

import UIKit

class CurrentCardView: UIView {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var apparentTemperatureLabel: UILabel!
    @IBOutlet weak var uvIndexLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)!
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = 10
    }
    
//    @IBAction func cardTapped(_ sender: UITapGestureRecognizer) {
//        enableHapticFeedback()
//
//    if height.constant == 60 {
//            height.constant = 200
//            summaryLabel.isHidden = false
//            slotLabel0.isHidden = false
//            slotLabel1.isHidden = false
//    } else {
//            height.constant = 60
//            summaryLabel.isHidden = true
//            slotLabel0.isHidden = true
//            slotLabel1.isHidden = true
//        }
//    }
}

func setupCurrentCard(view: CurrentCardView) {
    view.locationLabel.text = ""
    view.currentTemperatureLabel.text = "\(Int(CurrentForecast.sharedInstance.temp))°"
    view.apparentTemperatureLabel.text = "Feels like: \(Int(CurrentForecast.sharedInstance.apparentTemp))°"
    view.conditionImage.image = UIImage(systemName: "\(CurrentForecast.sharedInstance.symbol)")
    
    let uvIndex = CurrentForecast.sharedInstance.uvIndex
    if uvIndex <= 2 {
        view.uvIndexLabel.text = "UV Index is low at \(uvIndex)"
    } else if uvIndex >= 3 && uvIndex <= 5 {
        view.uvIndexLabel.text = "UV Index is moderate at \(uvIndex)"
    } else if uvIndex >= 6 && uvIndex <= 7 {
        view.uvIndexLabel.text = "UV Index is high at \(uvIndex)"
    } else if uvIndex >= 8 && uvIndex <= 10 {
        view.uvIndexLabel.text = "UV Index is very high at \(uvIndex)"
    } else if uvIndex >= 11 {
        view.uvIndexLabel.text = "UV Index is extreme at \(uvIndex)"
    }
    
    let humidity = Int(CurrentForecast.sharedInstance.humidity * 100)
    if humidity < 25 {
        view.humidityLabel.text = "Humidity is low at \(humidity)%"
    } else if humidity >= 25 && humidity < 70 {
        view.humidityLabel.text = "Humidity is fair at \(humidity)%"
    } else if humidity >= 70 {
        view.humidityLabel.text = "Humidity is high at \(humidity)%"
    }
    
    let windSpeed = CurrentForecast.sharedInstance.windSpeed.rounded()
    let windDirection = CurrentForecast.sharedInstance.windDirection
    let windGust = CurrentForecast.sharedInstance.windGust.rounded()
    var windDescription: String = ""
    let windUnits = "km/h"
    if windSpeed == 0 {
        windDescription = "Winds are calm at"
    } else if windSpeed >= 1 && windSpeed <= 5 {
        windDescription = "Winds are light at"
    } else if windSpeed >= 6 && windSpeed <= 11 {
        windDescription = "Light breeze at"
    } else if windSpeed >= 12 && windSpeed <= 28 {
        windDescription = "Gentle breeze at"
    } else if windSpeed >= 29 && windSpeed <= 49 {
        windDescription = "Strong breeze at"
    } else if windSpeed >= 50 && windSpeed <= 74 {
        windDescription = "Winds are strong at"
    } else if windSpeed >= 75 && windSpeed <= 102 {
        windDescription = "Winds are very strong at"
    } else if windSpeed >= 102 {
        windDescription = "Storm force winds at"
    }
    view.windLabel.text = "\(windDescription) \(Int(windSpeed))(\(Int(windGust)))\(windUnits) \(windDirection)"
    
    let pressure = Int(CurrentForecast.sharedInstance.pressure)
    view.pressureLabel.text = "Pressure is \(pressure)"
}
