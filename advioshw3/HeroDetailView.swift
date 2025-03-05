//
//  HeroDetailView.swift
//  advioshw3
//
//  Created by Dias Jakupov on 05.03.2025.
//

import SwiftUI

struct HeroDetailView: View {
    let hero: Superhero
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 20) {
                    // Hero Image
                    AsyncImage(url: URL(string: hero.images.lg)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(15)
                            .shadow(radius: 10)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 300)
                    
                    // Hero Name
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
                            .multilineTextAlignment(.center)
                        
                        VStack(alignment: .center, spacing: 10) {
                            HeroInfoRow(label: "Gender", value: hero.appearance.gender)
                            HeroInfoRow(label: "Race", value: hero.appearance.race ?? "Unknown")
                        }
                        .padding(.horizontal)
                    }
                }
                // Add padding to respect the safe area (plus some extra spacing)
                .padding(.top, geometry.safeAreaInsets.top + 16)
                .padding(.bottom, geometry.safeAreaInsets.bottom + 16)
                .frame(minHeight: geometry.size.height)
            }
            // Extend the scroll view's background into the safe areas
            .edgesIgnoringSafeArea(.all)
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
            Text(label + ":")
                .fontWeight(.bold)
            Text(value.isEmpty ? "Unknown" : value)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
