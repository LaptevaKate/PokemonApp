//
//  RealmManager.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 15.09.23.
//

import Foundation
import RealmSwift

final class RealmManager {
    static let manager = RealmManager()
    
    private init() {}
    private var realm: Realm {
        return try! Realm()
    }
    
    func objects<T: Object>(_ type: T.Type, predicate: NSPredicate? = nil) -> Results<T> {
        return predicate == nil ? realm.objects(type) : realm.objects(type).filter(predicate!)
    }
    
    func add<T: Object>(_ data: T, update: Realm.UpdatePolicy = .all) {
        if realm.isInWriteTransaction {
            realm.add([data], update: update)
        } else {
            try? realm.write {
                realm.add([data], update: update)
            }
        }
    }
    
    func add<T: Object>(_ data: [T], update: Realm.UpdatePolicy = .all) {
        if realm.isInWriteTransaction {
            realm.add(data, update: update)
        } else {
            try? realm.write {
                realm.add(data, update: update)
            }
        }
    }
}
