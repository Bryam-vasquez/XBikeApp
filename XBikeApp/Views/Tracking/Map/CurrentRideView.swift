//
//  CurrentRideView.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 30/03/25.
//

import SwiftUI
import GoogleMaps

struct CurrentRideView: View {
    @StateObject private var viewModel = CurrentRideViewModel()
    @State private var showPopup = false
    
    var body: some View {
        NavigationView {
            ZStack {
                GoogleMapView(route: $viewModel.routeCoordinates)
                    .ignoresSafeArea()
                
                if showPopup {
                    RidePopupView(viewModel: viewModel, dismissAction: {
                        showPopup = false
                    })
                    .transition(.scale)
                }
            }
            .navigationTitle("Current Ride")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                showPopup = true
                viewModel.startRide()
            }, label: {
                Image(systemName: "plus")
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)
            }))
        }
    }
}

//#Preview {
  //  CurrentRideView()
//}
