//
//  CurrentWeatherModel.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 8/18/22.
//

import Foundation

class GlobalForecastVariables {
    
    static let sharedInstance = GlobalForecastVariables()
    private init() {}
    
    var symbol: String = ""
    var temp: Double = 0
    var apparentTemp: Double = 0
    var uvIndex: Int = 0
    var humidity: Double = 0
    var windSpeed: Double = 0
    var pressure: Double = 0
    
}

struct DailyForecast {
    let day: Date
    let symbol: String
    let highTemp: Double
    let lowTemp: Double
    let precipChance: Double
}
