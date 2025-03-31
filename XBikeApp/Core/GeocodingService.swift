//
//  GeocodingService.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 31/03/25.
//

import Foundation
import CoreLocation


protocol GeocodingServiceProtocol {
    func reverseGeocode(coordinate: CLLocationCoordinate2D, completion: @escaping (String?) -> Void)
}

class GeocodingService: GeocodingServiceProtocol {
    private let geocoder = CLGeocoder()
    
    func reverseGeocode(coordinate: CLLocationCoordinate2D, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                var address = ""
                if let thoroughfare = placemark.thoroughfare {
                    if let subThoroughfare = placemark.subThoroughfare {
                        address += "\(subThoroughfare) "
                    }
                    address += thoroughfare
                }
                if let locality = placemark.locality {
                    address += (address.isEmpty ? locality : ", \(locality)")
                }
                if address.isEmpty, let name = placemark.name {
                    address = name
                }
                completion(address.isEmpty ? "Unknown location" : address)
            } else {
                completion("Unknown location")
            }
        }
    }
}
