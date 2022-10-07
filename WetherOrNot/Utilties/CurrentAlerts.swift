//
//  CurrentAlerts.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 10/7/22.
//

import Foundation

class CurrentAlerts {
    
    static let sharedInstance = CurrentAlerts()
    private init() {}
    
    var isEmpty: Bool = true
    var summary: String = ""
    var detailsURL: URL?
}
