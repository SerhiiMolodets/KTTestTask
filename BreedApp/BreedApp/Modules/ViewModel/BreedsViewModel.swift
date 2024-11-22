//
//  BreedsViewModel.swift
//  BreedApp
//
//  Created by Serhii Molodets on 22.11.2024.
//

import Foundation

@Observable
class BreedsViewModel {
    var breeds: [Breed] = []
    var searchText: String = ""
    var isLoading: Bool = false
    private let apiClient: BreedAppClient
    
    var filteredBreeds: [Breed] {
        if searchText.isEmpty {
            return breeds
        } else {
            return breeds.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    init(apiClient: BreedAppClient) {
        self.apiClient = apiClient
    }
    
    func getBreeds() async {
        isLoading = true
        do {
            let gotBreeds = try await apiClient.getBreeds()
            breeds = gotBreeds
            await getImagesForBreeds()
        } catch {
            print("Error fetching breeds: \(error)")
        }
        isLoading = false
    }
    
    private func getImagesForBreeds() async {
        for index in breeds.indices {
            guard let imageId = breeds[index].referenceImageId else { continue }
            do {
                let image = try await apiClient.getImage(for: imageId)
                    breeds[index].breedImage = image
            } catch {
                print("Error fetching image for breed \(breeds[index].id): \(error)")
            }
        }
    }
    
    
}
