//
//  LocationModel.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 10/10/22.
//

import Foundation

var userSelectedLocation: Bool = false
var userSelectedLocationRow: Int = 0
var locationsArray: [Location] = [Location(latitude: 0, longitude: 0, name: "Current Location")]

struct Location: Codable {
    let latitude: Double
    let longitude: Double
    let name: String
}
