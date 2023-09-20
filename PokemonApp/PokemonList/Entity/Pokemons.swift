//
//  Pokemons.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//

import Foundation
import RealmSwift

class PokemonData: Object, Decodable {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var results: RealmSwift.List<Pokemon>
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //_id = UUID().uuidString
        let resultsList = try container.decode([Pokemon].self, forKey: .results)
        results.append(objectsIn: resultsList)
    }
}

class Pokemon: Object, Decodable {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var name: String
    @Persisted var urlString: String
    
    var url: URL? {
        return URL(string: urlString)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case urlString = "url"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        urlString = try container.decode(String.self, forKey: .urlString)
        if let url {
            _id = url.pathComponents.last ?? "0"
        } else {
            _id = "0"
        }
    }
}
