//
//  CurrentForecast.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 8/18/22.
//

import Foundation
import WeatherKit
import CoreLocation

class FetchWeather: ObservableObject {
    
    func fetchCurrent() async {
        let weatherService = WeatherService()
        let melbourne = CLLocation(
             latitude: -37.815018,
             longitude: 144.946014
        )
        
        let weather = try! await weatherService.weather(for: melbourne)
    }
}
