//
//  PokemonDetail.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//

import Foundation


struct PokemonDetail: Codable {
    let height: Int
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
    let weight: Int
}

struct TypeElement: Codable {
    let slot: Int
    let type: Types
}

struct Sprites: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct Types: Codable {
    let name: String
    let url: String
}



