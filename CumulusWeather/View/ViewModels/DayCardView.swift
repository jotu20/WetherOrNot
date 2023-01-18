//
//  DayCardView.swift
//  CumulusWeather
//
//  Created by Joseph Szafarowicz on 9/1/22.
//

import UIKit

class DayCardView: UIView {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
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
        
    }
}

func setupDayCard(view: DayCardView, dayNumber: Int, data: FetchWeather) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    let dayOfTheWeekString = dateFormatter.string(from: data.dailyForecastArray[dayNumber].day)
    
    let highTemp = Measurement(value: data.dailyForecastArray[dayNumber].highTemp, unit: UnitTemperature.celsius)
    let lowTemp = Measurement(value: data.dailyForecastArray[dayNumber].lowTemp, unit: UnitTemperature.celsius)
    if defaults.string(forKey: "temperatureUnits") == "F" {
        view.temperatureLabel.text = "\(Int(highTemp.converted(to: .fahrenheit).value))°/\(Int(lowTemp.converted(to: .fahrenheit).value))°"
    } else {
        view.temperatureLabel.text = "\(Int(highTemp.converted(to: .celsius).value))°/\(Int(lowTemp.converted(to: .celsius).value))°"
    }
    
    if dayNumber == 0 {
        view.dayLabel.text = "Today"
    } else {
        view.dayLabel.text = dayOfTheWeekString
    }

    view.precipitationLabel.text = "\(Int(data.dailyForecastArray[dayNumber].precipChance * 100))%"
    view.conditionImage.image = UIImage(systemName: "\(data.dailyForecastArray[dayNumber].symbol)")
}
