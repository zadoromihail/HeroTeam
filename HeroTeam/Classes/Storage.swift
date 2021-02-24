//
//  Storage.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 21.02.2021.
//

import Foundation
import RealmSwift
import Realm

extension Realm {
    static var instance: Realm {
        let configuration = Realm.Configuration(schemaVersion: 1)
        return try! Realm(configuration: configuration)
    }
}

class Storage {
    private var realmInstance: Realm {
        return Realm.instance
    }
    
    func cachedPlainObject<T: Translatable>() -> [T] {
        let realm = realmInstance
        let realmObjects = Array(realm.objects(T.ManagedObject.self))
        let translatedObjects = realmObjects.map { T(object: $0) }
        return translatedObjects
    }
    
    func save<T: Translatable>(objetct: T) throws {
        let realm = realmInstance
        let realmObject = objetct.toManagedObject()
        try realm.write {
            realm.add(realmObject, update: .modified)
        }
    }
    
    func delete<T: Translatable & AutoTranslatable>(object: T) throws {
        let realm = realmInstance
        guard let realmObject = realm.object(ofType: T.ManagedObject.self, forPrimaryKey: object.translatablePrimaryKey()) else { return }
        try realm.write {
            realm.delete(realmObject)
        }
    }
    
    func deleteAll() throws {
        let realm = realmInstance
        try realm.write {
            realm.deleteAll()
        }
    }
}

