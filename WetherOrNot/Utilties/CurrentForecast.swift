//
//  CurrentForecast.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 8/18/22.
//

import WeatherKit
import CoreLocation

class FetchWeather {
    var dailyForecasts: [DailyForecast] = []
    
    func fetchCurrent(latitude: Double, longitude: Double) async {
        let weatherService = WeatherService()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        let weather = try! await weatherService.weather(for: location)
        
        let dailyWeather = weather.dailyForecast.forecast
        let dailyForecasts = Array(dailyWeather.prefix(5)).map {
            DailyForecast(
                day: $0.date,
                symbol: $0.symbolName,
                highTemp: $0.highTemperature.value,
                lowTemp: $0.lowTemperature.value,
                precipChance: $0.precipitationChance
             )
          }
   
          DispatchQueue.main.async {
              self.dailyForecasts = dailyForecasts
              print(dailyForecasts)
          }
    }
}
