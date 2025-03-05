//
//  FavoritesView.swift
//  advioshw3
//
//  Created by Dias Jakupov on 06.03.2025.
//

import SwiftUI

struct FavoritesView: View {
    let heroes: [Superhero]
    @Binding var selectedHero: Superhero?
    @State private var favoriteHeroes: [Superhero] = []
    let dismiss: () -> Void
    
    var body: some View {
        NavigationView {
            List {
                if favoriteHeroes.isEmpty {
                    Text("No favorite heroes yet")
                        .foregroundColor(.gray)
                } else {
                    ForEach(favoriteHeroes) { hero in
                        Button(action: {
                            selectedHero = hero
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
                            }
                        }
                    }
                    .onDelete(perform: removeFromFavorites)
                }
            }
            .navigationTitle("Favorite Heroes")
            .onAppear(perform: loadFavorites)
        }
    }
    
    private func loadFavorites() {
        let favoriteIds = FavoritesManager.shared.getFavorites()
        favoriteHeroes = heroes.filter { favoriteIds.contains($0.id) }
    }
    
    private func removeFromFavorites(at offsets: IndexSet) {
        offsets.forEach { index in
            let heroId = favoriteHeroes[index].id
            FavoritesManager.shared.removeFromFavorites(heroId: heroId)
        }
        loadFavorites()
    }
}
