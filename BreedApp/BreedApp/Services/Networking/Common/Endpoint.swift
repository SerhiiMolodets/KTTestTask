//
//  BreedEndpoint.swift
//  BreedApp
//
//  Created by Serhii Molodets on 22.11.2024.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var token: String? { get }
    var apiKey: String? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return APIConfig.domain
    }
    
    var token: String? {
        return nil
    }
    
    var apiKey: String? {
        return APIConfig.apiKey
    }
}
