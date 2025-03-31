//
//  GoogleMapView.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 30/03/25.
//

import GoogleMaps
import SwiftUI

struct GoogleMapView: UIViewRepresentable {
    @Binding var route: [CLLocationCoordinate2D]
    
    private let mapView = GMSMapView(frame: .zero)
    private let polyline = GMSPolyline()
    private let path = GMSMutablePath()
    
    func makeUIView(context: Context) -> GMSMapView {
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        polyline.strokeColor = UIColor.orange
        polyline.strokeWidth = 4.0
        polyline.map = mapView
        
        return mapView
    }
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        path.removeAllCoordinates()
        for coord in route {
            path.add(coord)
        }
        polyline.path = path
        
        if let lastCoord = route.last {
            let camera = GMSCameraPosition.camera(withLatitude: lastCoord.latitude,
                                                  longitude: lastCoord.longitude,
                                                  zoom: 16)
            uiView.animate(to: camera)
        } else if let userLocation = uiView.myLocation {
            let camera = GMSCameraPosition.camera(withLatitude: userLocation.coordinate.latitude,
                                                  longitude: userLocation.coordinate.longitude,
                                                  zoom: 16)
            uiView.animate(to: camera)
        }
    }
}
