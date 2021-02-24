//
//  Team.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 20.02.2021.
//

import Foundation
import RealmSwift

struct Team {
    var title: String?
    var heroes: [Hero?] = []
    var leader: Hero?
    var uuid = UUID().uuidString
    
    mutating func addHero(hero: Hero) {
        heroes.append(hero)
    }
    
    mutating func cleanTeam() {
        heroes = []
    }
    
    mutating func selectLeader(leader: Hero) {
        self.leader = leader
    }
    
    init(name: String) {
        self.title = name
        self.heroes = [Hero]()
        self.leader = nil
    }
}

extension Team: Translatable {
    
    init(object: _Team) {
        
        title = object.title
        
        guard let data = object.leader else {
            leader = nil
            return
        }
        
        leader = Hero(object: data)
        
        let arrayOfheroes = object.heroes
        
        arrayOfheroes.forEach { hero in
            
            var someThings = [String]()
            
            hero.things.forEach {someThings.append($0)}
            
            let someHero = Hero(
                charId: hero.charId,
                name: hero.name,
                birthday: hero.birthday,
                occupation: hero.occupation,
                img: hero.img,
                status: hero.status,
                nickname: hero.nickname,
                appearance: hero.appearance,
                portrayed: hero.portrayed,
                category: hero.category,
                betterCallSaulAppearance: hero.betterCallSaulAppearance,
                isLeader: hero.isLeader,
                heroUuid: hero.heroUuid,
                quote: hero.quote,
                things: someThings
            )
            
            heroes.append(someHero)
            uuid = object.uuid
        }
    }
    
    func toManagedObject() -> _Team {
        
        let object = _Team()
        
        if let leader = leader {
            let _leader = _Hero()
            _leader.appearance = leader.appearance
            _leader.name = leader.name
            _leader.betterCallSaulAppearance = leader.betterCallSaulAppearance
            _leader.birthday = leader.birthday
            _leader.category = leader.category
            _leader.charId = leader.charId
            _leader.img = leader.img
            _leader.nickname = leader.nickname
            _leader.occupation = leader.occupation
            _leader.portrayed = leader.portrayed
            _leader.heroUuid = leader.heroUuid
            _leader.quote = leader.quote
            
            leader.things?.forEach{ _leader.things.append($0)}
             
            object.leader = _leader
        }
        
        object.title = title
        object.uuid = uuid
        
        for hero in heroes {
            
            guard let someHero = hero else { return object }
            
            let realmHero = RealmHero()
            
            realmHero.name = someHero.name
            realmHero.img  = someHero.img
            realmHero.appearance = someHero.appearance
            realmHero.betterCallSaulAppearance = someHero.betterCallSaulAppearance
            realmHero.birthday = someHero.birthday
            realmHero.category = someHero.category
            realmHero.charId = someHero.charId
            realmHero.isLeader = someHero.isLeader
            realmHero.nickname = someHero.nickname
            realmHero.occupation = someHero.occupation
            realmHero.portrayed = someHero.portrayed
            realmHero.status = someHero.status
            realmHero.heroUuid = someHero.heroUuid
            realmHero.quote = someHero.quote
            
            someHero.things?.forEach{ realmHero.things.append($0)}
            
            
            object.heroes.append(realmHero)
        }
        
        return object
    }
}

extension Team: AutoTranslatable {
    func translatablePrimaryKey() -> String {
        return uuid
    }
}

@objcMembers
class _Team: Object {
    
    dynamic var title: String?
    let heroes = List<RealmHero>()
    dynamic var leader: _Hero?
    dynamic var uuid = UUID().uuidString
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
}

