//
//  Types.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 17.09.23.
//

import Foundation
import RealmSwift

class Types: Object, Decodable {
    @Persisted var name: String
    @Persisted var url: String
    
    enum CodingKeys: String, CodingKey {
        case name, url
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        url = try container.decode(String.self, forKey: .url)
    }
}
