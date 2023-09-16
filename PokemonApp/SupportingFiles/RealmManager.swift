//
//  RealmManager.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 15.09.23.
//

import Foundation
import RealmSwift

private protocol RealmOperations {
    static func write<T: Object>(_ object: T?, block: @escaping ((Realm, T?) -> Void))
    static func add(_ object: Object)
    static func add<S: Sequence>(_ objects: S) where S.Iterator.Element: Object
    static func get<R: Object>(fromEntity entity : R.Type, withPredicate predicate: NSPredicate?,
                               sortedByKey sortKey: String?, inAscending isAscending: Bool) -> Results<R>
    static func delete(_ object: Object)
    static func delete<S: Sequence>(_ objects: S) where S.Iterator.Element: Object
    static func delete(fromEntity entity: Object.Type, withPredicate predicate: NSPredicate?)
    static func update<T: Object>(_ object: T, block: @escaping ((T) -> Void))
}

class RealmManager {
  
    static func realmConfig() -> Realm.Configuration {
        return Realm.Configuration(schemaVersion: 2, migrationBlock: { (migration, oldSchemaVersion) in
        })
    }
    private static func realmInstance() -> Realm {
        do {
            let newRealm = try Realm(configuration: realmConfig())
            return newRealm
        } catch {
            print(error)
            fatalError("Unable to create an instance of Realm")
        }
    }
}


extension RealmManager: RealmOperations {
    fileprivate static func write<T: Object>(_ object: T? = nil, block: @escaping ((Realm, T?) -> Void)) {
        DispatchQueue(label: "realm").sync {
            autoreleasepool {
                let currentRealm = realmInstance()

                if currentRealm.isInWriteTransaction {
                    return
                } else {
                    do {
                        try currentRealm.write {
                            block(currentRealm, object)
                        }
                    } catch {
                        return
                    }
                }
            }
        }
    }
    

    static func add(_ object: Object) {
        write { (realmInstance, _) in
            realmInstance.add(object, update: .all)
        }
    }
    

    static func add<S: Sequence>(_ objects: S) where S.Iterator.Element: Object {
        write { (realmInstance, _) in
            realmInstance.add(objects, update: .all)
        }
    }
    

    static func get<R: Object>(fromEntity entity : R.Type, withPredicate predicate: NSPredicate? = nil, sortedByKey sortKey: String? = nil, inAscending isAscending: Bool = true) -> Results<R> {
        var objects = realmInstance().objects(entity)
        if predicate != nil {
            objects = objects.filter(predicate!)
        }
        if sortKey != nil {
            objects = objects.sorted(byKeyPath: sortKey!, ascending: isAscending)
        }
        
        return objects
    }
    
    static func delete(_ object: Object) {
        write(object) { (realmInstance, newObject) in
            guard let newObject = newObject, !newObject.isInvalidated else {
                return
            }
            realmInstance.delete(newObject)
        }
    }
    
    static func delete<S: Sequence>(_ objects: S) where S.Iterator.Element: Object {
        write { (realmInstance, _) in
            realmInstance.delete(objects)
        }
    }
    
    static func delete(fromEntity entity: Object.Type, withPredicate predicate: NSPredicate? = nil) {
        Self.delete(get(fromEntity: entity, withPredicate: predicate))
    }
    
    static func update<T: Object>(_ object: T, block: @escaping ((T) -> Void)) {
        guard !object.isInvalidated else {
            return
        }
        
        write(object) { (_, newObject) in
            guard let newObject = newObject, !newObject.isInvalidated else {
                return
            }
            block(newObject)
        }
    }
}



extension RealmManager {
    
    func getPokemonsByID(offset: Int, limit: Int) -> [RealmPokemon] {
        let pokemons = RealmManager.get(fromEntity: RealmPokemon.self, withPredicate: NSPredicate(format: "id >= %d AND id < %d", offset, limit))
        return Array(pokemons)
    }
    
    func getPokemonsByName(query: String) -> [RealmPokemon] {
        let pokemons = RealmManager.get(fromEntity: RealmPokemon.self, withPredicate: NSPredicate(format: "name beginswith[cd] %@", query), sortedByKey: "id", inAscending: true)
        return Array(pokemons)
    }
    
    func getPokemonsByType(query: String) -> [RealmPokemon] {
        let pokemons = RealmManager.get(fromEntity: RealmPokemon.self, withPredicate: NSPredicate(format: "type contains[cd] %@", query), sortedByKey: "id", inAscending: true)
        return Array(pokemons)
    }
    
}

