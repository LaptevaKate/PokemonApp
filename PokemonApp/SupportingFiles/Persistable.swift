//
//  Persistable.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 16.09.23.
//

import Foundation
import RealmSwift

public protocol Persistable {
    associatedtype ManagedObject: Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}
