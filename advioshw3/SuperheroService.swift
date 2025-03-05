//
//  SuperheroService.swift
//  advioshw3
//
//  Created by Dias Jakupov on 05.03.2025.
//

import Foundation

class SuperheroService {
    static let shared = SuperheroService()
    private let baseURL = "https://akabab.github.io/superhero-api/api/all.json"
    
    private init() {}
    
    func fetchHeroes(completion: @escaping ([Superhero]?, Error?) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not create URL"]))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode),
                  let data = data else {
                completion(nil, NSError(domain: "Network Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response or no data"]))
                return
            }
            do {
                let heroes = try JSONDecoder().decode([Superhero].self, from: data)
                DispatchQueue.main.async { completion(heroes, nil) }
            } catch {
                DispatchQueue.main.async { completion(nil, error) }
            }
        }.resume()
    }
    
    func getRandomHero(from heroes: [Superhero]) -> Superhero? {
        heroes.randomElement()
    }
}

