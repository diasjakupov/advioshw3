//
//  HeroRandomizerView.swift
//  advioshw3
//
//  Created by Dias Jakupov on 05.03.2025.
//

import SwiftUI

struct HeroRandomizerView: View {
    @State private var heroes: [Superhero] = []
    @State private var currentHero: Superhero?
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var showSearch = false
    @State private var searchText = ""
    @State private var showFavorites = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading Heroes...")
                } else if let error = errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .padding()
                } else if let hero = currentHero {
                    HeroDetailView(hero: hero, onFavoriteToggle: { heroId in
                        toggleFavorite(heroId: heroId)
                    })
                    .transition(.asymmetric(
                        insertion: .scale.combined(with: .opacity),
                        removal: .scale.combined(with: .opacity)
                    ))
                }
                HStack(spacing: 16) {
                    Button(action: fetchRandomHero) {
                        Label("Random Hero", systemImage: "shuffle")
                    }
                    .buttonStyle(HeroButtonStyle(backgroundColor: .blue, foregroundColor: .white))
                    
                    Button(action: { showSearch.toggle() }) {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    .buttonStyle(HeroButtonStyle(backgroundColor: .green, foregroundColor: .white))
                    
                    Button(action: { showFavorites.toggle() }) {
                        Label("Favorites", systemImage: "star.fill")
                    }
                    .buttonStyle(HeroButtonStyle(backgroundColor: .yellow, foregroundColor: .black))
                }
                .padding()
            }
            .sheet(isPresented: $showSearch) {
                SearchView(heroes: heroes, searchText: $searchText, selectedHero: $currentHero, dismiss: { showSearch.toggle() })
            }
            .sheet(isPresented: $showFavorites) {
                FavoritesView(heroes: heroes, selectedHero: $currentHero, dismiss: { showFavorites.toggle() })
            }
            .onAppear(perform: loadInitialHeroes)
            .animation(.spring(), value: currentHero)
            .navigationTitle("Hero Randomizer")
        }
    }
    
    private func loadInitialHeroes() {
        isLoading = true
        SuperheroService.shared.fetchHeroes { fetchedHeroes, error in
            isLoading = false
            if let error = error {
                errorMessage = error.localizedDescription
                return
            }
            heroes = fetchedHeroes ?? []
            fetchRandomHero()
        }
    }
    
    private func fetchRandomHero() {
        if heroes.isEmpty {
            loadInitialHeroes()
        } else {
            withAnimation {
                currentHero = SuperheroService.shared.getRandomHero(from: heroes)
            }
        }
    }
    
    private func toggleFavorite(heroId: Int) {
        if FavoritesManager.shared.isFavorite(heroId: heroId) {
            FavoritesManager.shared.removeFromFavorites(heroId: heroId)
        } else {
            FavoritesManager.shared.addToFavorites(heroId: heroId)
        }
    }
}

struct HeroButtonStyle: ButtonStyle {
    var backgroundColor: Color
    var foregroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(backgroundColor)
            )
            .foregroundColor(foregroundColor)
            .shadow(color: backgroundColor.opacity(0.3), radius: 5, x: 0, y: 3)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
