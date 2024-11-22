//
//  BreedsClient.swift
//  BreedApp
//
//  Created by Serhii Molodets on 22.11.2024.
//

import Foundation

protocol BreedAppClient: HTTPClient {
    func getBreeds() async throws -> [Breed]
    func search(query: String) async throws -> [Breed]
}

struct BreedsClient: BreedAppClient {
    private let decoder: JSONDecoder = {
        $0.keyDecodingStrategy = .convertFromSnakeCase
        return $0
    }(JSONDecoder())
    
    func getBreeds() async throws -> [Breed] {
        return try await sendRequest(endpoint: BreedsEndpoint.breeds, useCache: true, decoder: decoder)
    }
    
    func search(query: String) async throws -> [Breed] {
        return try await sendRequest(endpoint: BreedsEndpoint.search(query: query), useCache: false, decoder: decoder)
    }
}
