//
//  GoogleMapView.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 30/03/25.
//

import SwiftUI
import UIKit
import GoogleMaps

struct GoogleMapView: UIViewControllerRepresentable {
    @Binding var route: [CLLocationCoordinate2D]
    var initialCoordinate: CLLocationCoordinate2D?
    
    func makeUIViewController(context: Context) -> MapViewController {
        let controller = MapViewController()
        controller.initialCenterCoordinate = initialCoordinate
        return controller
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        uiViewController.updateRoute(with: route)
    }
}

class MapViewController: UIViewController {
    var mapView: GMSMapView!
    var initialCenterCoordinate: CLLocationCoordinate2D?
    private var polyline: GMSPolyline?
    private var path: GMSMutablePath?
    
    override func loadView() {
        let defaultCoord = CLLocationCoordinate2D(latitude: -12.0464, longitude: -77.0428)
        let camera = GMSCameraPosition.camera(withTarget: initialCenterCoordinate ?? defaultCoord, zoom: 16)
        let map = GMSMapView()
        map.camera = camera
        map.settings.zoomGestures = true
        map.settings.scrollGestures = true
        map.isMyLocationEnabled = true
        self.view = map
        self.mapView = map
    }
    
    func updateRoute(with coordinates: [CLLocationCoordinate2D]) {
        guard !coordinates.isEmpty else {
            polyline?.map = nil
            polyline = nil
            path = nil
            return
        }
        if polyline == nil {
            path = GMSMutablePath()
            for coord in coordinates {
                path?.add(coord)
            }
            polyline = GMSPolyline(path: path)
            polyline?.strokeColor = .systemBlue
            polyline?.strokeWidth = 5.0
            polyline?.map = mapView
        } else {
            guard let path = path else { return }

            let existingCount = path.count()
            let newCoords = coordinates.dropFirst(Int(existingCount))

            for coord in newCoords {
                path.add(coord)
            }

            polyline?.path = path
        }
        if let lastCoord = coordinates.last {
            mapView.animate(to: GMSCameraPosition(target: lastCoord, zoom: 17))
        }
    }
}
