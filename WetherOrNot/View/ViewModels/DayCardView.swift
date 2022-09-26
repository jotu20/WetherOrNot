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
        layer.cornerRadius = CGFloat(GlobalVariables.sharedInstance.cornerRadius)
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

func setupDayCard(view: DayCardView, dayNumber: Int, data: FetchWeather) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    let dayOfTheWeekString = dateFormatter.string(from: data.dailyForecast[dayNumber].day)

    view.dayLabel.text = dayOfTheWeekString
    view.highTemperatureLabel.text = "\(Int(data.dailyForecast[dayNumber].highTemp))°"
    view.lowTemperatureLabel.text = "\(Int(data.dailyForecast[dayNumber].lowTemp))°"
    view.precipitationLabel.text = "\(Int(data.dailyForecast[dayNumber].precipChance * 100))%"
    view.conditionImage.image = UIImage(systemName: "\(data.dailyForecast[dayNumber].symbol)")
}
