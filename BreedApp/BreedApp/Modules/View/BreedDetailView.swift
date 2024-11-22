//
//  BreedDetailView.swift
//  BreedApp
//
//  Created by Serhii Molodets on 22.11.2024.
//

import SwiftUI

struct BreedDetailView: View {
    let breed: Breed
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 16) {
                let imageURL = URL(string: breed.breedImage?.url ?? "")
                CachedAsyncImage(url: imageURL, urlCache: .detailImageCache) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.gray
                }
                .frame(height: 300)
                .cornerRadius(12)
                
                VStack(alignment: .leading) {
                    Text(breed.temperament)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(breed.description)
                        .font(.body)
                }
            }
            .padding()
        }
        .navigationTitle(breed.name)
    }
}
