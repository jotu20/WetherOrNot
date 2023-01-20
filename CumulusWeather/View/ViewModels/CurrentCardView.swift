//
//  CurrentCardView.swift
//  CumulusWeather
//
//  Created by Joseph Szafarowicz on 9/1/22.
//

import UIKit

class CurrentCardView: UIView {
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    //@IBOutlet weak var conditionLabel: UILabel!
    //@IBOutlet weak var apparentTemperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var uvIndexLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
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
        layer.cornerRadius = CGFloat(GlobalVariables.sharedInstance.cornerRadius)
        setColor(view: self, value: defaults.integer(forKey: "color"))
    }
}

func setupCurrentCard(view: CurrentCardView) {
    view.currentTemperatureLabel.text = "\(Int(CurrentForecast.sharedInstance.temp))°"
    //view.conditionLabel.text = "\(CurrentForecast.sharedInstance.condition)"
    //view.apparentTemperatureLabel.text = "Feels like: \(Int(CurrentForecast.sharedInstance.apparentTemp))°"
    view.sunriseLabel.text = "Sunrise \(CurrentForecast.sharedInstance.sunrise.lowercased())"
    view.sunsetLabel.text = "Sunset \(CurrentForecast.sharedInstance.sunset.lowercased())"
    view.conditionImage.image = UIImage(systemName: "\(CurrentForecast.sharedInstance.symbol)")
    view.conditionImage.image = UIImage(named: setConditionImage(condition: CurrentForecast.sharedInstance.symbol))
    
    let uvIndex = CurrentForecast.sharedInstance.uvIndex
    if uvIndex <= 2 {
        view.uvIndexLabel.text = "UV Index low (\(uvIndex))"
    } else if uvIndex >= 3 && uvIndex <= 5 {
        view.uvIndexLabel.text = "UV Index moderate (\(uvIndex))"
    } else if uvIndex >= 6 && uvIndex <= 7 {
        view.uvIndexLabel.text = "UV Index high (\(uvIndex))"
    } else if uvIndex >= 8 && uvIndex <= 10 {
        view.uvIndexLabel.text = "UV Index very high (\(uvIndex))"
    } else if uvIndex >= 11 {
        view.uvIndexLabel.text = "UV Index extreme (\(uvIndex))"
    }
    
    let humidity = Int(CurrentForecast.sharedInstance.humidity * 100)
    if humidity < 25 {
        view.humidityLabel.text = "Humidity low (\(humidity)%)"
    } else if humidity >= 25 && humidity < 70 {
        view.humidityLabel.text = "Humidity fair (\(humidity)%)"
    } else if humidity >= 70 {
        view.humidityLabel.text = "Humidity high (\(humidity)%)"
    }
    
    let windSpeed = CurrentForecast.sharedInstance.windSpeed.rounded()
    let windDirection = CurrentForecast.sharedInstance.windDirection
    let windGust = CurrentForecast.sharedInstance.windGust.rounded()
    let windUnits = defaults.string(forKey: "windUnits") ?? ""
    view.windLabel.text = "Wind \(Int(windSpeed))(\(Int(windGust)))\(windUnits) \(windDirection)"
    
    let pressure = Int(CurrentForecast.sharedInstance.pressure)
    let pressureUnits = defaults.string(forKey: "pressureUnits") ?? ""
    view.pressureLabel.text = "Pressure \(pressure)\(pressureUnits)"
}
