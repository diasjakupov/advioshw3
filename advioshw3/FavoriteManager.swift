//
//  FavoriteManager.swift
//  advioshw3
//
//  Created by Dias Jakupov on 06.03.2025.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    private let favoritesKey = "favoriteHeroes"
    
    private init() {}
    
    func getFavorites() -> [Int] {
        return UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
    }
    
    func addToFavorites(heroId: Int) {
        var favorites = getFavorites()
        if !favorites.contains(heroId) {
            favorites.append(heroId)
            UserDefaults.standard.set(favorites, forKey: favoritesKey)
        }
    }
    
    func removeFromFavorites(heroId: Int) {
        var favorites = getFavorites()
        favorites.removeAll { $0 == heroId }
        UserDefaults.standard.set(favorites, forKey: favoritesKey)
    }
    
    func isFavorite(heroId: Int) -> Bool {
        return getFavorites().contains(heroId)
    }
}
