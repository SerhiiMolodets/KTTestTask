//
//  SearchBar.swift
//  BreedApp
//
//  Created by Serhii Molodets on 22.11.2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search breeds...", text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }
        .padding()
    }
}
