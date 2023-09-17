//
//  Sprites.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 17.09.23.
//

import UIKit
import RealmSwift

class Sprites: Object, Decodable {
    @Persisted var frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        frontDefault = try container.decode(String.self, forKey: .frontDefault)
    }
}
