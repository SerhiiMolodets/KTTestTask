//
//  BreedsEndpoint.swift
//  BreedApp
//
//  Created by Serhii Molodets on 22.11.2024.
//

import Foundation
enum BreedsEndpoint: Endpoint {
    case breeds
    case detail(id: String)
    case search(query: String)
    case getImage(id: String)
    
    var path: String {
        switch self {
        case .breeds:
            return "/v1/breeds"
        case .detail(id: let id):
            return "/v1/breeds/\(id)"
        case .search:
            return "/v1/breeds/search"
        case .getImage(id: let id):
            return "/v1/images/\(id)"
        }
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var header: [String: String]? {
        return nil
    }
    var body: [String: String]? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .search(query: query):
            return [URLQueryItem(name: "q", value: query)]
        default :
            return nil
        }
    }
}
