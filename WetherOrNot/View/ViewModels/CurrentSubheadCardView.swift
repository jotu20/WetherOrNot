//
//  CurrentSubheadCardView.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 9/21/22.
//

import UIKit

class CurrentSubheadCardView: UIView {
    
    @IBOutlet weak var descriptionImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)!
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = CGFloat(GlobalVariables.sharedInstance.cornerRadius)
    }
}

func setupCurrentSubheadCard(view: CurrentSubheadCardView, type: String) {
    view.descriptionLabel.text = type
    
    if type == "UV Index" {
        view.descriptionImage.image = UIImage(systemName: "sun.min")
        let uvIndex = CurrentForecast.sharedInstance.uvIndex
        if uvIndex <= 2 {
            view.valueLabel.text = "Low (\(uvIndex))"
        } else if uvIndex >= 3 && uvIndex <= 5 {
            view.valueLabel.text = "Moderate (\(uvIndex))"
        } else if uvIndex >= 6 && uvIndex <= 7 {
            view.valueLabel.text = "High (\(uvIndex))"
        } else if uvIndex >= 8 && uvIndex <= 10 {
            view.valueLabel.text = "Very high (\(uvIndex))"
        } else if uvIndex >= 11 {
            view.valueLabel.text = "Extreme (\(uvIndex))"
        }
    } else if type == "Humidity" {
        view.descriptionImage.image = UIImage(systemName: "humidity")
        let humidity = Int(CurrentForecast.sharedInstance.humidity * 100)
        if humidity < 25 {
            view.valueLabel.text = "Low (\(humidity)%)"
        } else if humidity >= 25 && humidity < 70 {
            view.valueLabel.text = "Fair (\(humidity)%)"
        } else if humidity >= 70 {
            view.valueLabel.text = "High (\(humidity)%)"
        }
    } else if type == "Wind" {
        view.descriptionImage.image = UIImage(systemName: "wind")
        let windSpeed = CurrentForecast.sharedInstance.windSpeed.rounded()
        let windDirection = CurrentForecast.sharedInstance.windDirection
        let windGust = CurrentForecast.sharedInstance.windGust.rounded()
        let windUnits = defaults.string(forKey: "windUnits") ?? ""
        view.valueLabel.text = "\(Int(windSpeed))(\(Int(windGust)))\(windUnits) \(windDirection)"
    } else if type == "Pressure" {
        view.descriptionImage.image = UIImage(systemName: "gauge.high")
        let pressure = Int(CurrentForecast.sharedInstance.pressure)
        let pressureUnits = defaults.string(forKey: "pressureUnits") ?? ""
        view.valueLabel.text = "\(pressure)\(pressureUnits)"
    }
}
