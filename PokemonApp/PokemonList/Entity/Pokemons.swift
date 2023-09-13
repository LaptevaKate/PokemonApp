//
//  Pokemons.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//

import Foundation

struct Response: Codable {
    let count: Int
    let next: String?
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let url: String
}
