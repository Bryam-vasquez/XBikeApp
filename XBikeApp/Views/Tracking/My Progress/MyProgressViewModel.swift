//
//  MyProgressViewModel.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 31/03/25.
//

import Foundation
import Combine

final class MyProgressViewModel: ObservableObject {
    
    @Published private(set) var rides: [Ride] = []
    
    private let rideRepository: RideRepository
    
    init(rideRepository: RideRepository) {
        self.rideRepository = rideRepository
    }
    
    func loadRides() {
        rides = rideRepository.fetchRides()
    }
}

