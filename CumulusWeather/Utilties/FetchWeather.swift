//
//  CurrentForecast.swift
//  CumulusWeather
//
//  Created by Joseph Szafarowicz on 8/18/22.
//

import WeatherKit
import CoreLocation
import UIKit

class FetchWeather {
    var dailyForecastArray: [DailyForecast] = []
    
    func fetch(vc: UIViewController, latitude: Double, longitude: Double) async {
        print("fetching...")
        let weatherService = WeatherService()
        let location = CLLocation(latitude: latitude, longitude: longitude)

        do {
            print("fetch successful")
            let weather = try await weatherService.weather(for: location)
            
            let currentWeather = weather.currentWeather
            let dailyWeather = weather.dailyForecast.forecast
            let weatherAlerts = weather.weatherAlerts
            
            if weatherAlerts?.isEmpty == false {
                CurrentAlerts.sharedInstance.isEmpty = false
                CurrentAlerts.sharedInstance.summary = weatherAlerts?[0].summary.description ?? ""
                CurrentAlerts.sharedInstance.detailsURL = "\(String(describing: weatherAlerts?[0].detailsURL))"
            } else {
                CurrentAlerts.sharedInstance.isEmpty = true
            }
            
            CurrentForecast.sharedInstance.symbol = currentWeather.symbolName
            CurrentForecast.sharedInstance.condition = currentWeather.condition.description
            CurrentForecast.sharedInstance.uvIndex = currentWeather.uvIndex.value
            CurrentForecast.sharedInstance.humidity = currentWeather.humidity
            
            let temperature = Measurement(value: currentWeather.temperature.value, unit: UnitTemperature.celsius)
            let apparentTemperature = Measurement(value: currentWeather.apparentTemperature.value, unit: UnitTemperature.celsius)
            if defaults.string(forKey: "temperatureUnits") == "F" {
                CurrentForecast.sharedInstance.temp = temperature.converted(to: .fahrenheit).value
                CurrentForecast.sharedInstance.apparentTemp = apparentTemperature.converted(to: .fahrenheit).value
            } else {
                CurrentForecast.sharedInstance.temp = temperature.converted(to: .celsius).value
                CurrentForecast.sharedInstance.apparentTemp = apparentTemperature.converted(to: .celsius).value
            }
            
            let windSpeed = Measurement(value: currentWeather.wind.speed.value, unit: UnitSpeed.kilometersPerHour)
            let windGust = Measurement(value: currentWeather.wind.gust!.value, unit: UnitSpeed.kilometersPerHour)
            CurrentForecast.sharedInstance.windDirection = currentWeather.wind.compassDirection.abbreviation
            if defaults.string(forKey: "windUnits") == "mph" {
                CurrentForecast.sharedInstance.windSpeed = windSpeed.converted(to: .milesPerHour).value
                CurrentForecast.sharedInstance.windGust = windGust.converted(to: .milesPerHour).value
            } else {
                CurrentForecast.sharedInstance.windSpeed = windSpeed.converted(to: .kilometersPerHour).value
                CurrentForecast.sharedInstance.windGust = windGust.converted(to: .kilometersPerHour).value
            }
            
            let pressure = Measurement(value: currentWeather.pressure.value, unit: UnitPressure.millimetersOfMercury)
            if defaults.string(forKey: "pressureUnits") == "inHg" {
                CurrentForecast.sharedInstance.pressure = pressure.converted(to: .inchesOfMercury).value
            } else {
                CurrentForecast.sharedInstance.pressure = pressure.converted(to: .millimetersOfMercury).value
            }
            
            let currentCondition = currentWeather.condition.description.lowercased()
            let cloudCover = Int(currentWeather.cloudCover * 100)
            
            let dateFormatter = DateFormatter()
            if defaults.string(forKey: "clock") == "12h" {
                dateFormatter.dateFormat = "h:mma"
            } else {
                dateFormatter.dateFormat = "HH:mm"
            }
            
            CurrentForecast.sharedInstance.sunrise = dateFormatter.string(from: dailyWeather[0].sun.sunrise ?? Date())
            CurrentForecast.sharedInstance.sunset = dateFormatter.string(from: dailyWeather[0].sun.sunset ?? Date())
            
            func getDayWeather(day: Int) {
                let test = Array(arrayLiteral: dailyWeather[day]).map {
                    DailyForecast(
                        day: $0.date,
                        symbol: $0.symbolName,
                        highTemp: $0.highTemperature.value,
                        lowTemp: $0.lowTemperature.value,
                        precipChance: $0.precipitationChance
                     )
                }
                
                for i in test {
                    dailyForecastArray.append(i)
                }
            }
            
            getDayWeather(day: 0)
            getDayWeather(day: 1)
            getDayWeather(day: 2)
            getDayWeather(day: 3)
            getDayWeather(day: 4)
            getDayWeather(day: 5)
            getDayWeather(day: 6)
            getDayWeather(day: 7)
            getDayWeather(day: 8)
            getDayWeather(day: 9)
        } catch {
            print("error fetching data")
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "", message: "Uh oh! Looks like there was an error fetching your local weather.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                vc.present(alert, animated: true)
            }
        }
    }
}
