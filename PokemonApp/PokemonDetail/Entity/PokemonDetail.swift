//
//  PokemonDetail.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//

import Foundation
import RealmSwift

class PokemonDetail: Object, Decodable {
    @Persisted(primaryKey: true) var _id: Int
    @Persisted var name: String
    @Persisted var height: Int
    @Persisted var weight: Int
    @Persisted var types: RealmSwift.List<TypeElement>
    @Persisted var sprites: Sprites?
    
    enum CodingKeys: String, CodingKey {
            case id, name, height, weight, types, sprites
        }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        height = try container.decode(Int.self, forKey: .height)
        weight = try container.decode(Int.self, forKey: .weight)
        let typesList = try container.decode([TypeElement].self, forKey: .types)
        types.append(objectsIn: typesList)
        sprites = try container.decode(Sprites.self, forKey: .sprites)
    }
}
