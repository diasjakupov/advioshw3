//
//  HeroDetailView.swift
//  advioshw3
//
//  Created by Dias Jakupov on 05.03.2025.
//

import SwiftUI

struct HeroDetailView: View {
    let hero: Superhero
    let onFavoriteToggle: (Int) -> Void
    @State private var isFavorite: Bool

    init(hero: Superhero, onFavoriteToggle: @escaping (Int) -> Void) {
        self.hero = hero
        self.onFavoriteToggle = onFavoriteToggle
        _isFavorite = State(initialValue: FavoritesManager.shared.isFavorite(heroId: hero.id))
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 20) {
                    AsyncImage(url: URL(string: hero.images.lg)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(15)
                            .shadow(radius: 10)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 300)
                    
                    Text(hero.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    Group {
                        Text("Powerstats")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                        HStack(alignment: .center) {
                            PowerstatView(title: "Intelligence", value: hero.powerstats.intelligence)
                            PowerstatView(title: "Strength", value: hero.powerstats.strength)
                            PowerstatView(title: "Speed", value: hero.powerstats.speed)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    Group {
                        Text("Biography")
                            .font(.headline)
                            .italic()
                            .multilineTextAlignment(.center)
                        VStack(alignment: .center, spacing: 10) {
                            HeroInfoRow(label: "Full Name", value: hero.biography.fullName)
                            HeroInfoRow(label: "Place of Birth", value: hero.biography.placeOfBirth)
                            HeroInfoRow(label: "First Appearance", value: hero.biography.firstAppearance)
                        }
                        .padding(.horizontal)
                    }
                    
                    Group {
                        Text("Appearance")
                            .font(.headline)
                            .italic()
                            .multilineTextAlignment(.center)
                        VStack(alignment: .center, spacing: 10) {
                            HeroInfoRow(label: "Gender", value: hero.appearance.gender)
                            HeroInfoRow(label: "Race", value: hero.appearance.race ?? "Unknown")
                        }
                        .padding(.horizontal)
                    }
                    
                    Button(action: {
                        onFavoriteToggle(hero.id)
                        isFavorite = FavoritesManager.shared.isFavorite(heroId: hero.id)
                    }) {
                        HStack {
                            Image(systemName: isFavorite ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                            Text(isFavorite ? "Remove from Favorites" : "Add to Favorites")
                        }
                        .padding()
                        .background(Color.yellow.opacity(0.2))
                        .cornerRadius(10)
                    }
                }
                .padding(.top, geometry.safeAreaInsets.top + 16)
                .padding(.bottom, geometry.safeAreaInsets.bottom + 16)
                .frame(minHeight: geometry.size.height)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .onChange(of: hero.id) { _, newId in
            isFavorite = FavoritesManager.shared.isFavorite(heroId: newId)
        }
    }
}

struct PowerstatView: View {
    let title: String
    let value: Int

    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
            Text("\(value)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
    }
}

struct HeroInfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text("\(label):")
                .fontWeight(.bold)
            Text(value.isEmpty ? "Unknown" : value)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

