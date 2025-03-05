//
//  HeroModel.swift
//  advioshw3
//
//  Created by Dias Jakupov on 05.03.2025.
//

struct Superhero: Codable, Identifiable {
    let id: Int
    let name: String
    let powerstats: PowerStats
    let biography: Biography
    let appearance: Appearance
//    let work: Work
//    let connections: Connections
    let images: HeroImages
}

struct PowerStats: Codable {
    let intelligence: Int
    let strength: Int
    let speed: Int
    let durability: Int
    let power: Int
    let combat: Int
}

struct Biography: Codable {
    let fullName: String
    let placeOfBirth: String
    let firstAppearance: String
}

struct Appearance: Codable {
    let gender: String
    let race: String? 
}

struct Work: Codable {
    let occupation: String
    let base: String
}

struct Connections: Codable {
    let groupAffiliation: String
    let relatives: String
}

struct HeroImages: Codable {
    let xs: String
    let sm: String
    let md: String
    let lg: String
}
