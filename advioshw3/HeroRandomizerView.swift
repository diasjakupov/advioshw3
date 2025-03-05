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
    
    private var buttonTitle: String {
        heroes.isEmpty ? "Load Heroes" : "Get Random Hero"
    }
    
    var body: some View {
        VStack {
            content
            
            Button(action: fetchRandomHero) {
                Text(buttonTitle)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(isLoading)
            .padding()
        }
        .onAppear(perform: loadHeroes)
    }
    
    @ViewBuilder
    private var content: some View {
        if isLoading {
            ProgressView("Loading Heroes...")
        } else if let error = errorMessage {
            Text("Error: \(error)")
                .foregroundColor(.red)
                .padding()
        } else if let hero = currentHero {
            HeroDetailView(hero: hero)
        }
    }
    
    private func loadHeroes() {
        guard !isLoading else { return }
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
            loadHeroes()
        } else {
            currentHero = SuperheroService.shared.getRandomHero(from: heroes)
        }
    }
}

