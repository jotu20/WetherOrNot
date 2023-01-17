//
//  CurrentWeatherModel.swift
//  CumulusWeather
//
//  Created by Joseph Szafarowicz on 8/18/22.
//

import Foundation

var forecastLoaded: Bool = false
var settingsChanged: Bool = false

struct DailyForecast {
    let day: Date
    let symbol: String
    let highTemp: Double
    let lowTemp: Double
    let precipChance: Double
}
