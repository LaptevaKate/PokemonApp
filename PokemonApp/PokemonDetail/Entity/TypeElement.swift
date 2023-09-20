//
//  TypeElement.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 17.09.23.
//

import Foundation
import RealmSwift

class TypeElement: Object, Decodable {
    @Persisted var slot: Int
    @Persisted var type: Types?
    
    enum CodingKeys: CodingKey {
        case slot
        case type
    }
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        slot = try container.decode(Int.self, forKey: .slot)
        type = try container.decode(Types.self, forKey: .type)
    }
}
