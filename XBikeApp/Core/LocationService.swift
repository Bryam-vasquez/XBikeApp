//
//  LocationService.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 30/03/25.
//

import Combine
import CoreLocation

protocol LocationServiceProtocol {
    var onLocationUpdate: ((CLLocationCoordinate2D) -> Void)? { get set }
    func startTracking()
    func stopTracking()
}

class LocationService: NSObject, LocationServiceProtocol, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    var onLocationUpdate: ((CLLocationCoordinate2D) -> Void)?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func startTracking() {
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
        
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }
    
    func stopTracking() {
        manager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        let coord = newLocation.coordinate
        DispatchQueue.main.async {
            self.onLocationUpdate?(coord)
        }
    }
}

