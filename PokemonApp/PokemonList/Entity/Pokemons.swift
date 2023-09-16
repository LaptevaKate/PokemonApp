//
//  Pokemons.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//

import Foundation
import RealmSwift

struct PokemonData: Codable {
    var results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let url: String
}

extension Pokemon: Persistable {
    init(managedObject: RealmPokemon) {
        name = managedObject.name
        url = managedObject.url
    }
    
    func managedObject() -> RealmPokemon {
        let pokemon = RealmPokemon()
        
        pokemon.name = name
        pokemon.url = url
        
        return pokemon
    }
}

final class RealmPokemon: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var url: String = ""
    
}

extension RealmPokemon {
    func convertToPokemon() -> Pokemon {
        return Pokemon(name: name, url: url)
    }
}
