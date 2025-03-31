//
//  XBikeAppApp.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 29/03/25.
//

import SwiftUI

@main
struct XBikeAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage(Constants.Configuration.onboardingStorage) private var hasSeenOnboarding = false
    
    init() {
        Appearance.setup()
    }
    
    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                ContentView()
            } else {
                OnboardingView()
            }
        }
    }
}
