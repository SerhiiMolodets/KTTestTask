//
//  MainView.swift
//  BreedApp
//
//  Created by Serhii Molodets on 22.11.2024.
//

import SwiftUI

struct MainView: View {
    @State var viewModel = BreedsViewModel(apiClient: BreedsClient())
    
    var body: some View {
        contentView
            .banner(bannerManager: viewModel.bannerManager)
            .task {
                await viewModel.getBreeds()
                print(viewModel.breeds)
            }
    }
}

private extension MainView {
    var contentView: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .frame(maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
                            ForEach(viewModel.filteredBreeds) { breed in
                                NavigationLink(destination: BreedDetailView(breed: breed)) {
                                    BreedCell(breed: breed)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Breeds")
        }
    }
}

#Preview {
    MainView()
}
