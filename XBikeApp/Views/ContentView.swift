//
//  ContentView.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 29/03/25.
//

import SwiftUI
import Combine

struct ContentView: View {
    private var locationService = CoreLocationService()
    var body: some View {
        TabView {
            CurrentRideView()
                .tabItem {
                    Label("Current Ride", image: "")
                }
            
            Color(.blue)
                .tabItem {
                    Label("My Progress", image: "")
                }
        }
        .onAppear {
            locationService.requestAuthorization()
        }
    }
}

#Preview {
    ContentView()
}
