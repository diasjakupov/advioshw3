//
//  SearchView.swift
//  advioshw3
//
//  Created by Dias Jakupov on 06.03.2025.
//

import SwiftUI

struct SearchView: View {
    let heroes: [Superhero]
    @Binding var searchText: String
    @Binding var selectedHero: Superhero?
    let dismiss: () -> Void

    
    var filteredHeroes: [Superhero] {
        guard !searchText.isEmpty else { return [] }
        return heroes.filter { hero in
            hero.name.localizedCaseInsensitiveContains(searchText) ||
            hero.biography.fullName.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        VStack {
            TextField("Search Heroes", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            List(filteredHeroes) { hero in
                Button(action: {
                    selectedHero = hero
                    searchText = ""
                    dismiss()
                }) {
                    HStack {
                        AsyncImage(url: URL(string: hero.images.sm)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        VStack(alignment: .leading) {
                            Text(hero.name)
                                .font(.headline)
                            Text(hero.biography.fullName)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: FavoritesManager.shared.isFavorite(heroId: hero.id) ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                    }
                }
            }
        }
    }
}

