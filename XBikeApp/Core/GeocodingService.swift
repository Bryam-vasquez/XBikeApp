//
//  GeocodingService.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 31/03/25.
//

import Foundation
import GoogleMaps

protocol GeocodingServiceProtocol {
    func reverseGeocode(coordinate: CLLocationCoordinate2D, completion: @escaping (String?) -> Void)
}

class GeocodingService: GeocodingServiceProtocol {
    private let geocoder = GMSGeocoder()

    func reverseGeocode(coordinate: CLLocationCoordinate2D, completion: @escaping (String?) -> Void) {
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let result = response?.firstResult(), let lines = result.lines {
                completion(lines.joined(separator: ", "))
            } else {
                completion(nil)
            }
        }
    }
}
