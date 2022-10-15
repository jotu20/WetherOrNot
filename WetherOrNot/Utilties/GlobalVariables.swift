//
//  GlobalVariables.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 9/15/22.
//

import Foundation

class GlobalVariables {
    
    static let sharedInstance = GlobalVariables()
    private init() {}
    
    var latitude: Double = 37.33259552
    var longitude: Double = -122.03031802
    var locationName: String = ""
    let cornerRadius = 15
    var description: String = "I couldn't get enough info so I'm not sure what you might need :("
}
