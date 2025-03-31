//
//  CurrentRideView.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 30/03/25.
//

import SwiftUI
import GoogleMaps

struct CurrentRideView: View {
    @StateObject private var viewModel = CurrentRideViewModel()
    @State private var showPopup = false
    
    var body: some View {
        NavigationView {
            ZStack {
                GoogleMapView(route: $viewModel.routeCoordinates)
                    .ignoresSafeArea()
                
                if showPopup {
                    RidePopupView(viewModel: viewModel, dismissAction: {
                        showPopup = false
                    })
                    .transition(.scale)
                }
            }
            .navigationTitle("Current Ride")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                showPopup = true
                viewModel.startRide()
            }, label: {
                Image(systemName: "plus")
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)
            }))
        }
    }
}

struct GoogleMapView: UIViewRepresentable {
    @Binding var route: [CLLocationCoordinate2D]
    
    private let mapView = GMSMapView(frame: .zero)
    private let polyline = GMSPolyline()
    private let path = GMSMutablePath()
    
    func makeUIView(context: Context) -> GMSMapView {
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        polyline.strokeColor = .red
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
        }
    }
}


//#Preview {
  //  CurrentRideView()
//}
