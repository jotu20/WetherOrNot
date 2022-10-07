//
//  CurrentCardView.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 9/1/22.
//

import UIKit

class CurrentCardView: UIView {
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
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
        setColor(view: self, value: defaults.integer(forKey: "color"))
    }
}

func setupCurrentCard(view: CurrentCardView) {
    view.currentTemperatureLabel.text = "\(Int(CurrentForecast.sharedInstance.temp))°"
    view.conditionLabel.text = "\(CurrentForecast.sharedInstance.condition)"
    view.apparentTemperatureLabel.text = "Feels like: \(Int(CurrentForecast.sharedInstance.apparentTemp))°"
    view.sunriseLabel.text = "\(CurrentForecast.sharedInstance.sunrise.lowercased())"
    view.sunsetLabel.text = "\(CurrentForecast.sharedInstance.sunset.lowercased())"
    view.conditionImage.image = UIImage(systemName: "\(CurrentForecast.sharedInstance.symbol)")
}
