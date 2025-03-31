//
//  TextConstants.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 30/03/25.
//

import Foundation

enum Constants {
    enum Configuration {
        // GoogleMaps SDK constants
        static let googleInfoPlist = "GoogleMapsConfiguration"
        static let plistExtension = "plist"
        static let googleApiKey = "GOOGLE_MAPS_API_KEY"
        
        // Onboarding storage constants
        static let onboardingStorage = "hasSeenOnboarding"
    }
}

enum TextConstants {
    enum Onboarding {
        static let slide1 = "Extremely simple to use"
        static let slide2 = "Track your time and distance"
        static let slide3 = "See your progress and challenge yourself!"
        static let getStartedButton = "Get Started"
        
        enum Icons {
            static let easyIcon = "easy"
            static let progressIcon = "progress"
            static let timeIcon = "time"
        }
    }
    
    enum CurrentRide {
        static let distanceText = "0.00 km"
        static let elapsedTimeText = "00:00:00"
    }
}
