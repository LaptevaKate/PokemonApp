//
//  Pokemon.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//

import Foundation

struct PokemonDetail: Codable {
    let name: String
    let sprites: Sprites
    let height: Int
    let weight: Int
    let id: Int
    let types: [Types]
}

struct Types: Codable {
    let type: Type
}

struct Type: Codable {
    let name: String
}

struct Sprites: Codable {
    let front_default: String?
    
    public static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    var stringURL: String {
        if let frontDefault = front_default {
            return frontDefault
        } else { return "" }
    }
}
