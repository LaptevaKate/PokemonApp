//
//  RealmPokemon.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 15.09.23.
//

import Foundation
import RealmSwift

final class RealmPokemonDetail: Object, Decodable {
    
    @Persisted var name: String = ""
    @Persisted var image: Data?
    @Persisted var height: Int = 0
    @Persisted var weight: Int = 0
    @Persisted var types: String
    @Persisted var id: Int = 0
    
}
 
