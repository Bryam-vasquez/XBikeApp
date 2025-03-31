//
//  RideRepository.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 30/03/25.
//

import Foundation
import CoreData
import CoreLocation

// MARK: - Protocol

protocol RideRepository {
    func save(ride: Ride, completion: @escaping (Result<Void, Error>) -> Void)
    func fetchRides() -> [Ride]
}

// MARK: - Implementation

class CoreDataRideRepository: RideRepository {
    
    private let context: NSManagedObjectContext
    private let geocoder: GeocodingServiceProtocol
    
    init(
        context: NSManagedObjectContext = PersistanceContainer.shared.viewContext,
        geocoder: GeocodingServiceProtocol = GeocodingService()
    ) {
        self.context = context
        self.geocoder = geocoder
    }
    
    func save(ride: Ride, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let startCoord = ride.coordinates.first,
              let endCoord = ride.coordinates.last else {
            completion(.failure(NSError(domain: "RideRepository", code: 1, userInfo: [NSLocalizedDescriptionKey: "Missing coordinates"])))
            return
        }

        let dispatchGroup = DispatchGroup()
        var startAddress: String?
        var endAddress: String?
        
        dispatchGroup.enter()
        geocoder.reverseGeocode(coordinate: startCoord) { address in
            startAddress = address
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        geocoder.reverseGeocode(coordinate: endCoord) { address in
            endAddress = address
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            let entity = RideEntity(context: self.context)
            entity.startTime = ride.startTime
            entity.endTime = ride.endTime
            entity.duration = ride.duration
            entity.distance = ride.totalDistance
            entity.startAddress = startAddress
            entity.endAddress = endAddress
            
            let coordsData = try? JSONEncoder().encode(
                ride.coordinates.map { ["lat": $0.latitude, "lng": $0.longitude] }
            )
            entity.routeData = coordsData
            
            do {
                try self.context.save()
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func fetchRides() -> [Ride] {
        let request: NSFetchRequest<RideEntity> = RideEntity.fetchRequest()
        
        do {
            let entities = try context.fetch(request)
            return entities.map { entity in
                let coords = decodeCoordinates(entity.routeData)
                return Ride(
                    startTime: entity.startTime ?? Date(),
                    endTime: entity.endTime,
                    duration: entity.duration, 
                    startAddress: entity.startAddress,
                    endAddress: entity.endAddress,
                    totalDistance: entity.distance,
                    coordinates: coords
                )
            }
        } catch {
            print("Error while fetching rides: \(error)")
            return []
        }
    }
    
    private func decodeCoordinates(_ data: Data?) -> [CLLocationCoordinate2D] {
        guard let data = data else { return [] }
        do {
            let array = try JSONDecoder().decode([CoordinateJSON].self, from: data)
            return array.map { CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lng) }
        } catch {
            return []
        }
    }
}

struct CoordinateJSON: Codable {
    let lat: Double
    let lng: Double
}
