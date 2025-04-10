//
//  ConfigurationService.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 30/03/25.
//

import Foundation

protocol ConfigurationServiceProtocol {
    var googleMapsAPIKey: String? { get }
}

final class ConfigurationService: ConfigurationServiceProtocol {
    private let config: [String: Any]
    
    init(bundle: Bundle = .main) {
        if let url = bundle.url(forResource: Constants.Configuration.googleInfoPlist, withExtension: Constants.Configuration.plistExtension),
           let data = try? Data(contentsOf: url),
           let config = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] {
            self.config = config
        } else {
            self.config = [:]
        }
    }
    
    init(config: [String: Any]) {
        self.config = config
    }
    
    var googleMapsAPIKey: String? {
        return config[Constants.Configuration.googleApiKey] as? String
    }
}
