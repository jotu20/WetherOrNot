//
//  AppDelegate.swift
//  WetherOrNot
//
//  Created by Joseph Szafarowicz on 7/18/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if defaults.string(forKey: "color") == nil {
            defaults.set(1, forKey: "color")
        }
        
        if defaults.string(forKey: "clock") == nil {
            defaults.set("12h", forKey: "clock")
        }
        
        if defaults.string(forKey: "temperatureUnits") == nil {
            defaults.set("F", forKey: "temperatureUnits")
        }
        
        if defaults.string(forKey: "windUnits") == nil {
            defaults.set("mph", forKey: "windUnits")
        }
        
        if defaults.string(forKey: "pressureUnits") == nil {
            defaults.set("inHg", forKey: "pressureUnits")
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

