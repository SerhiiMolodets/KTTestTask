//
//  MockBreedAppClient.swift
//  BreedApp
//
//  Created by Serhii Molodets on 22.11.2024.
//

import Foundation
@testable import BreedApp

class MockBreedAppClient: BreedAppClient {
    var breedsResponse: [Breed] = []
    var searchResponse: [Breed] = []
    var imageResponse: BreedImage?
    var shouldThrowError = false
    
    func getBreeds() async throws -> [Breed] {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        return breedsResponse
    }
    
    func search(query: String) async throws -> [Breed] {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        return searchResponse
    }
    
    func getImage(for id: String) async throws -> BreedImage {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        guard let image = imageResponse else {
            throw URLError(.badURL)
        }
        return image
    }
}
