//
//  ContentView.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 29/03/25.
//

import SwiftUI
import Combine

struct ContentView: View {
    private var locationService = LocationService()
    var body: some View {
        TabView {
            CurrentRideView()
                .tabItem {
                    Label("Current Ride", image: "")
                }.tint(.orange)
            
            MyProgressView(rideRepository: CoreDataRideRepository())
                .tabItem {
                    Label("My Progress", image: "")
                }.tint(.orange)
        }
    }
}

#Preview {
    ContentView()
}
