//
//  RideRepository.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 30/03/25.
//

import Foundation
import CoreData

protocol RideRepository {
    func save(ride: Ride)
}

class CoreDataRideRepository: RideRepository {
    private let context = PersistanceContainer.shared.viewContext
    func save(ride: Ride) {
        let entity = RideEntity(context: context)
        entity.startTime = ride.startTime
        entity.endTime = ride.endTime
        entity.duration = ride.duration
        entity.distance = ride.totalDistance
        // Transformar [CLLocationCoordinate2D] a Data
        let coordsData = try? JSONEncoder().encode(ride.coordinates.map { ["lat": $0.latitude, "lng": $0.longitude] })
        entity.routeData = coordsData
        try? context.save()
    }
}
