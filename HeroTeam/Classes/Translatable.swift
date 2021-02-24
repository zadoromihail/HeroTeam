//
//  Translatable.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 21.02.2021.
//

import Foundation
import RealmSwift

protocol Translatable {
    associatedtype ManagedObject: Object
    
    init(object: ManagedObject)
    func toManagedObject() -> ManagedObject
}

protocol AutoTranslatable {
    func translatablePrimaryKey() -> String
}
