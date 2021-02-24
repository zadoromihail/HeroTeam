//
//  Hero.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 19.02.2021.
//

import Foundation
import RealmSwift

struct Hero: Decodable,RealmCollectionValue {
    var charId: Int?
    var name: String?
    var birthday: String?
    var occupation: [String?]
    var img: String?
    var status: String?
    var nickname: String?
    var appearance: [Int?]
    var portrayed: String?
    var category: String?
    var betterCallSaulAppearance: [Int?]
    var isLeader: Bool?
    var heroUuid: String?
    var quote: String?
    var things: [String]?
}

@objcMembers
class RealmHero: Object  {
    dynamic var charId: Int?
    dynamic var name: String? 
    dynamic var birthday: String?
    dynamic var occupation: [String?] = []
    dynamic var img: String?
    dynamic var status: String?
    dynamic var nickname: String?
    dynamic var appearance: [Int?] = []
    dynamic var portrayed: String?
    dynamic var category: String?
    dynamic var betterCallSaulAppearance: [Int?] = []
    dynamic var isLeader: Bool?
    dynamic var heroUuid: String?
    dynamic var quote: String?
    let things = List<String>()
}

@objcMembers
class _Hero: Object {
    dynamic var charId: Int?
    dynamic var name: String?
    dynamic var birthday: String?
    dynamic var occupation: [String?] = []
    dynamic var img: String?
    dynamic var status: String?
    dynamic var nickname: String?
    dynamic var appearance: [Int?] = []
    dynamic var portrayed: String?
    dynamic var category: String?
    dynamic var betterCallSaulAppearance: [Int?] = []
    dynamic var isLeader: Bool?
    dynamic var heroUuid: String?
    dynamic var quote: String?
    let things = List<String>()
    
    override static func primaryKey() -> String? {
        return "heroUuid"
    }
}

extension Hero: Translatable {
    init(object: _Hero) {
        charId = object.charId
        name = object.name
        birthday = object.birthday
        occupation = object.occupation
        img = object.img
        status = object.status
        nickname = object.nickname
        appearance = object.appearance
        portrayed = object.portrayed
        category = object.category
        betterCallSaulAppearance = object.betterCallSaulAppearance
        isLeader = object.isLeader
        heroUuid = object.heroUuid
        quote = object.quote
        
        object.things.forEach { things?.append($0)}
    }
    
    func toManagedObject() -> _Hero {
        let object = _Hero()
        
        object.charId = charId
        object.name = name
        object.birthday = birthday
        object.occupation = occupation
        object.img = img
        object.status = status
        object.nickname = nickname
        object.appearance = appearance
        object.portrayed = portrayed
        object.category = category
        object.betterCallSaulAppearance = betterCallSaulAppearance
        object.isLeader = isLeader
        object.heroUuid = heroUuid
        object.quote = quote
        
        things?.forEach{ object.things.append($0)}
        
        return object
    }
}
