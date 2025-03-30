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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
