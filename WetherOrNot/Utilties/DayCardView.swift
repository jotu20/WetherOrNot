//
//  DayCardView.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 9/1/22.
//

import UIKit

class DayCardView: UIView {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    
    @IBOutlet weak var height: NSLayoutConstraint!
    
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

func setupDayCard(dayView: DayCardView, dayNumber: Int, data: FetchWeather) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    let dayOfTheWeekString = dateFormatter.string(from: data.dailyForecasts[dayNumber].day)

    dayView.dayLabel.text = dayOfTheWeekString
    dayView.highTemperatureLabel.text = "H: \(Int(data.dailyForecasts[dayNumber].highTemp))°"
    dayView.lowTemperatureLabel.text = "L: \(Int(data.dailyForecasts[dayNumber].lowTemp))°"
    dayView.precipitationLabel.text = "P: \(Int(data.dailyForecasts[dayNumber].precipChance * 100))%"
    dayView.conditionImage.image = UIImage(systemName: "\(data.dailyForecasts[dayNumber].symbol)")
}
