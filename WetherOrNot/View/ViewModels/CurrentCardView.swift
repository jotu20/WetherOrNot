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
    view.currentTemperatureLabel.text = "\(Int(CurrentForecast.sharedInstance.temp))"
    view.apparentTemperatureLabel.text = "\(Int(CurrentForecast.sharedInstance.apparentTemp))"
    view.uvIndexLabel.text = "\(CurrentForecast.sharedInstance.uvIndex)"
    view.humidityLabel.text = "\(Int(CurrentForecast.sharedInstance.humidity))"
    view.windLabel.text = "\(Int(CurrentForecast.sharedInstance.windSpeed))"
    view.pressureLabel.text = "\(Int(CurrentForecast.sharedInstance.pressure))"
    view.conditionImage.image = UIImage(systemName: "\(CurrentForecast.sharedInstance.symbol)")
}
