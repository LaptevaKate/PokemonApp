//
//  PokemonList.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//

import Foundation

struct Pokemons: Codable {
    let results: [PokemonListItem]
}

struct PokemonListItem: Codable {
    let name: String
    let url: String
    let id: Int
}
