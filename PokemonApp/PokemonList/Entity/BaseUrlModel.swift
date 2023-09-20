//
//  BaseUrlModel.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 20.09.23.
//

import Foundation

enum BaseURL: String {
    case authorization = "https://pokeapi.co/api/v2/pokemon?offset=0"
}
enum Path : String {
    case endPoint = "&limit=20"
}
