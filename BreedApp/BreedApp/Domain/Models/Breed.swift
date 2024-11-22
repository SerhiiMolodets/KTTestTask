//
//  Breed.swift
//  BreedApp
//
//  Created by Serhii Molodets on 22.11.2024.
//

import Foundation

struct Breed: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    let temperament: String
    let referenceImageId: String?
}
