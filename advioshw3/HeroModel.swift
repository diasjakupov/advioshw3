//
//  HeroModel.swift
//  advioshw3
//
//  Created by Dias Jakupov on 05.03.2025.
//

struct Superhero: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let powerstats: PowerStats
    let biography: Biography
    let appearance: Appearance
    let images: HeroImages
}

struct PowerStats: Codable, Equatable {
    let intelligence: Int
    let strength: Int
    let speed: Int
    let durability: Int
    let power: Int
    let combat: Int
}

struct Biography: Codable, Equatable {
    let fullName: String
    let placeOfBirth: String
    let firstAppearance: String
}

struct Appearance: Codable, Equatable {
    let gender: String
    let race: String? 
}

struct HeroImages: Codable, Equatable {
    let xs: String
    let sm: String
    let md: String
    let lg: String
}
