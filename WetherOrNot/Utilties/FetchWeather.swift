//
//  CurrentForecast.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 8/18/22.
//

import WeatherKit
import CoreLocation

class FetchWeather {
    var dailyForecast: [DailyForecast] = []
    
    func fetch(latitude: Double, longitude: Double) async {
        let weatherService = WeatherService()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        let weather = try! await weatherService.weather(for: location)
        
        let currentWeather = weather.currentWeather
        CurrentForecast.sharedInstance.symbol = currentWeather.symbolName
        CurrentForecast.sharedInstance.temp = currentWeather.temperature.value
        CurrentForecast.sharedInstance.apparentTemp = currentWeather.apparentTemperature.value
        CurrentForecast.sharedInstance.uvIndex = currentWeather.uvIndex.value
        CurrentForecast.sharedInstance.humidity = currentWeather.humidity
        CurrentForecast.sharedInstance.windSpeed = currentWeather.wind.speed.value
        CurrentForecast.sharedInstance.windGust = currentWeather.wind.gust!.value 
        CurrentForecast.sharedInstance.windDirection = currentWeather.wind.compassDirection.abbreviation
        CurrentForecast.sharedInstance.pressure = currentWeather.pressure.value
        
        let dailyWeather = weather.dailyForecast.forecast
        let dailyForecast = Array(dailyWeather.prefix(5)).map {
            DailyForecast(
                day: $0.date,
                symbol: $0.symbolName,
                highTemp: $0.highTemperature.value,
                lowTemp: $0.lowTemperature.value,
                precipChance: $0.precipitationChance
             )
          }
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "HH:mm"
        
        CurrentForecast.sharedInstance.sunrise = dateFormatterGet.string(from: dailyWeather[0].sun.sunrise ?? Date())
        CurrentForecast.sharedInstance.sunset = dateFormatterGet.string(from: dailyWeather[0].sun.sunset ?? Date())
   
          DispatchQueue.main.async {
              self.dailyForecast = dailyForecast
          }
    }
}
