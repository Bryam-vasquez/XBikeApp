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
    var duration: TimeInterval
    var startAddress: String?
    var endAddress: String?
    var totalDistance: CLLocationDistance
    var coordinates: [CLLocationCoordinate2D]
}
