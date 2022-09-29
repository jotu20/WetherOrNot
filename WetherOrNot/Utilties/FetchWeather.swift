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
        
        // Attire description
        if CurrentForecast.sharedInstance.temp >= 75 {
            GlobalVariables.sharedInstance.description = "This is great t-shirt weather!"
        } else if CurrentForecast.sharedInstance.temp < 75 && CurrentForecast.sharedInstance.temp > 50 {
            GlobalVariables.sharedInstance.description = "It's like that perfect spring weather for a light jacket."
        } else if CurrentForecast.sharedInstance.temp < 50 && CurrentForecast.sharedInstance.temp > 30 {
            GlobalVariables.sharedInstance.description = "Is it fall? You should probably grab your jacket."
        } else if CurrentForecast.sharedInstance.temp < 30 {
            GlobalVariables.sharedInstance.description = "You'll definetely want a heavy jacket today with these freezing temps."
        }
        
        let currentCondition = currentWeather.condition.description.lowercased()
        let cloudCover = Int(currentWeather.cloudCover * 100)
        if currentCondition.contains("sun") || currentCondition.contains("partly cloudy") && cloudCover < 50 {
            GlobalVariables.sharedInstance.description = "You might want your sunglasses."
        }
        
        if CurrentForecast.sharedInstance.uvIndex >= 8 {
            GlobalVariables.sharedInstance.description = "You'll definetely want sunscreen with these UV levels."
        }
        
        if currentCondition.contains("drizzle") {
            GlobalVariables.sharedInstance.description = "A rain jacket might be worth it in these conditions."
        }
        
        if currentCondition.contains("rain") {
            GlobalVariables.sharedInstance.description = "You should probably grab an umbrella or poncho with this rain."
        }
        
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
        
        let dateFormatter = DateFormatter()
        if defaults.string(forKey: "clock") == "12h" {
            dateFormatter.dateFormat = "h:mm a"
        } else {
            dateFormatter.dateFormat = "HH:mm"
        }
        
//        defaults.string(forKey: "clock") == "12h"
//
//        defaults.string(forKey: "temperatureUnits") == "F"
//
//        defaults.string(forKey: "windUnits") == "mph"
//
//        defaults.string(forKey: "pressureUnits") == "inHg"
        
        CurrentForecast.sharedInstance.sunrise = dateFormatter.string(from: dailyWeather[0].sun.sunrise ?? Date())
        CurrentForecast.sharedInstance.sunset = dateFormatter.string(from: dailyWeather[0].sun.sunset ?? Date())
   
          DispatchQueue.main.async {
              self.dailyForecast = dailyForecast
          }
    }
}
