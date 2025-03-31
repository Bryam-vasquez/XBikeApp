//
//  RideCardView+Extensions.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 31/03/25.
//

import Foundation
import CoreLocation

extension Ride {
    
    var formattedDuration: String {
        let seconds = Int(duration)
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let secs = seconds % 60
        
        if hours > 0 {
            return String(format: "%dh %dm %ds", hours, minutes, secs)
        } else {
            return String(format: "%dm %ds", minutes, secs)
        }
    }

    var formattedDistance: String {
        if totalDistance >= 1000 {
            return String(format: "%.2f km", totalDistance / 1000)
        } else {
            return String(format: "%.0f m", totalDistance)
        }
    }
}
