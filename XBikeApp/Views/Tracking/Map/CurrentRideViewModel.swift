//
//  CurrentRideViewModel.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 30/03/25.
//

import Combine
import CoreLocation

class CurrentRideViewModel: ObservableObject {
    @Published var isTracking: Bool = false
    @Published var elapsedTimeText: String = TextConstants.CurrentRide.elapsedTimeText
    @Published var distanceText: String = TextConstants.CurrentRide.distanceText
    @Published var lastKnownCoordinate: CLLocationCoordinate2D?
    @Published var routeCoordinates: [CLLocationCoordinate2D] = []
    
    var ride: Ride?
    
    private let locationService: LocationServiceProtocol
    private let rideRepository: RideRepository
    
    private var timer: Cancellable?
    
    init(locationService: LocationService = LocationService(),
         rideRepository: RideRepository = CoreDataRideRepository()) {
        self.locationService = locationService
        self.rideRepository = rideRepository
        
        locationService.onLocationUpdate = { [weak self] coordinate in
            guard let self = self else { return }
            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            self.handleLocationUpdate(location)
        }
        locationService.startTracking()
    }
    
    func startRide() {
        ride = Ride(startTime: Date(), endTime: nil, duration: TimeInterval(), startAddress: nil, endAddress: nil, totalDistance: 0, coordinates: [])
        routeCoordinates.removeAll()
        distanceText = TextConstants.CurrentRide.distanceText
        isTracking = true
        startTimer()
        locationService.startTracking()
    }
    
    func stopRide() {
        guard var ride = ride else { return }

        locationService.stopTracking()
        stopTimer()

        ride.endTime = Date()
        ride.duration = ride.endTime!.timeIntervalSince(ride.startTime)

        self.ride = ride
        isTracking = false
        elapsedTimeText = formatTime(ride.duration)
    }
    
    func saveRide() {
        guard let ride = ride else { return }
        rideRepository.save(ride: ride) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                self.ride = nil
            case .failure(_):
                self.ride = nil
            }
            
        }
        
    }
    
    func deleteRide() {
        self.ride = nil
        routeCoordinates.removeAll()
    }
    
    // MARK: - Private helpers
    
    private func handleLocationUpdate(_ location: CLLocation) {
        lastKnownCoordinate = location.coordinate
        guard isTracking, var currentRide = ride else { return }
        
        let coord = location.coordinate
        routeCoordinates.append(coord)
        currentRide.coordinates.append(coord)
        
        if let lastCoord = currentRide.coordinates.dropLast().last {
            let lastLocation = CLLocation(latitude: lastCoord.latitude, longitude: lastCoord.longitude)
            let distanceIncrement = lastLocation.distance(from: location)
            currentRide.totalDistance += distanceIncrement
            
            distanceText = String(format: "%.2f km", currentRide.totalDistance / 1000.0)
        }
        
        self.ride = currentRide
        
    }
    
    private func startTimer() {
        timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
            .sink(receiveValue: { [weak self] _ in
                self?.updateElapsedTime()
            })
    }
    
    private func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    private func updateElapsedTime() {
        guard let ride = ride else { return }
        let elapsed = Date().timeIntervalSince(ride.startTime)
        elapsedTimeText = formatTime(elapsed)
    }
    
    private func formatTime(_ interval: TimeInterval) -> String {
        let totalSeconds = Int(interval)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

