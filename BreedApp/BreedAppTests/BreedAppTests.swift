//
//  BreedAppTests.swift
//  BreedAppTests
//
//  Created by Serhii Molodets on 22.11.2024.
//

import XCTest
@testable import BreedApp

import XCTest

@MainActor
final class BreedsViewModelTests: XCTestCase {
    var mockClient: MockBreedAppClient!
    var viewModel: BreedsViewModel!
    
    override func setUp() {
        super.setUp()
        mockClient = MockBreedAppClient()
        viewModel = BreedsViewModel(apiClient: mockClient)
    }
    
    override func tearDown() {
        mockClient = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testGetBreedsSuccess() async {
        
        let testBreeds = [
            Breed(id: "1", name: "Test1", description: "Test1", temperament: "Test1", referenceImageId: "Test1"),
            Breed(id: "2", name: "Test2", description: "Test2", temperament: "Test2", referenceImageId: "Test2")
        ]
        
        let testImage = BreedImage(url: "etstst", id: "test")
        mockClient.breedsResponse = testBreeds
        mockClient.imageResponse = testImage
        
        await viewModel.getBreeds()
        
        XCTAssertEqual(viewModel.breeds.count, 2)
        XCTAssertEqual(viewModel.breeds.first?.name, "Test1")
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testGetBreedsFailure() async {
        mockClient.shouldThrowError = true
    
        await viewModel.getBreeds()
        
        XCTAssertTrue(viewModel.breeds.isEmpty, "Breeds should be empty on failure")
        XCTAssertFalse(viewModel.isLoading, "Loading should be false after failure")
    }

    
    func testGetImagesForBreedsSuccess() async {
        let testBreeds = [
            Breed(id: "1", name: "Test1", description: "Test1", temperament: "Test1", referenceImageId: "Test1")
        ]
        let testImage = BreedImage(url: "https://example.com/image.jpg", id: "testId")
        mockClient.breedsResponse = testBreeds
        mockClient.imageResponse = testImage
        await viewModel.getBreeds()
        
        XCTAssertEqual(viewModel.breeds.first?.breedImage?.url, "https://example.com/image.jpg")
    }
    
    func testGetImagesForBreedsFailure() async {
        let testBreeds = [
            Breed(id: "1", name: "Test1", description: "Test1", temperament: "Test1", referenceImageId: "Test1")
        ]
        mockClient.breedsResponse = testBreeds
        mockClient.shouldThrowError = true
        
        await viewModel.getBreeds()
        
        XCTAssertNil(viewModel.breeds.first?.breedImage)
    }
    
    func testFilteringBreeds() {
        let testBreeds = [
            Breed(id: "1", name: "Test1", description: "Test1", temperament: "Test1", referenceImageId: "Test1"),
            Breed(id: "2", name: "Test2", description: "Test2", temperament: "Test2", referenceImageId: "Test2")
        ]
        viewModel.breeds = testBreeds
        
        viewModel.searchText = "Test2"
        
        XCTAssertEqual(viewModel.filteredBreeds.count, 1)
        XCTAssertEqual(viewModel.filteredBreeds.first?.name, "Test2")
    }
}

