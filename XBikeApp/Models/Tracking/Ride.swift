//
//  Ride.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 30/03/25.
//

import Foundation
import CoreLocation

struct Ride {
    let startTime: Date
    var endTime: Date?
    var duration: TimeInterval {
        guard let end = endTime else { return Date().timeIntervalSince(startTime) }
        return end.timeIntervalSince(startTime)
    }
    var totalDistance: CLLocationDistance
    var coordinates: [CLLocationCoordinate2D]
}
