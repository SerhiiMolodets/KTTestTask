//
//  BreedCell.swift
//  BreedApp
//
//  Created by Serhii Molodets on 22.11.2024.
//

import SwiftUI

struct BreedCell: View {
    let breed: Breed
    
    var body: some View {
        VStack {
            let imageURL = URL(string: breed.breedImage?.url ?? "")
            CachedAsyncImage(url: imageURL, urlCache: .imageCache) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)
            } placeholder: {
                Color.gray
            }
            .frame(height: 120)
            .cornerRadius(8)
            
            Text(breed.name)
                .font(.headline)
                .lineLimit(1)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}
