//
//  CurrentCardView.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 9/1/22.
//

import UIKit

class CurrentCardView: UIView {
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var apparentTemperatureLabel: UILabel!
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
    view.currentTemperatureLabel.text = "\(Int(CurrentForecast.sharedInstance.temp))°"
    view.apparentTemperatureLabel.text = "Feels like: \(Int(CurrentForecast.sharedInstance.apparentTemp))°"
    view.sunriseLabel.text = "\(CurrentForecast.sharedInstance.sunrise)"
    view.sunsetLabel.text = "\(CurrentForecast.sharedInstance.sunset)"
    view.conditionImage.image = UIImage(systemName: "\(CurrentForecast.sharedInstance.symbol)")
}
