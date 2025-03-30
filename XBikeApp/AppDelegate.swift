//
//  AppDelegate.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 30/03/25.
//

import GoogleMaps
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    var configService: ConfigurationServiceProtocol = ConfigurationService()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if let apiKey = configService.googleMapsAPIKey {
            GMSServices.provideAPIKey(apiKey)
        } else {
            fatalError("Google Maps API Key not found in configuration.")
        }
        return true
    }
}
