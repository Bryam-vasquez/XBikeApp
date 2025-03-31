//
//  MyProgressView.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 31/03/25.
//

import SwiftUI

struct MyProgressView: View {
    
    @StateObject private var viewModel: MyProgressViewModel
    
    init(rideRepository: RideRepository) {
        _viewModel = StateObject(wrappedValue: MyProgressViewModel(rideRepository: rideRepository))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.rides, id: \.startTime) { ride in
                        RideCardView(ride: ride)
                    }
                }
                .padding()
            }
            .navigationTitle("My Progress")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                viewModel.loadRides()
            })
        }
    }
}

#Preview {
    MyProgressView(rideRepository: CoreDataRideRepository())
}
