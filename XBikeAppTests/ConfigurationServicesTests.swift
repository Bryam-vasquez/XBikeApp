//
//  ConfigurationServicesTests.swift
//  XBikeAppTests
//
//  Created by Juan Diego Olivas Maldonado on 30/03/25.
//

import XCTest
@testable import XBikeApp

final class ConfigurationServicesTests: XCTestCase {

    func testGoogleMapsAPIKey_ReturnsCorrectKey() {
            let expectedKey = "TEST_API_KEY"
            let config: [String: Any] = ["GOOGLE_MAPS_API_KEY": expectedKey]
            let service = ConfigurationService(config: config)
            
            XCTAssertEqual(service.googleMapsAPIKey, expectedKey)
        }
        
        func testGoogleMapsAPIKey_ReturnsNilWhenKeyMissing() {
            let config: [String: Any] = [:]
            let service = ConfigurationService(config: config)
            
            XCTAssertNil(service.googleMapsAPIKey)
        }

}
