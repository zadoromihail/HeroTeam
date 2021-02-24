//
//  Thing.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 24.02.2021.
//

import Foundation

enum Thing: CaseIterable {
    
    case book
    case cloak
    case bag
    case gun
    case knife
    case rope
    case flashlight
    case phone
    case key
    case watch
    case pen
    case apple
    case orange
    case banana
    case tablet
    case speaker
    case cash
    case bottle
    
    var parameter: String {
        return String(describing: self)
    }
    
    static func getRandom() -> [String] {
       
        let random1 = Int.random(in: 0..<6)
        let random2 = Int.random(in: 6..<12)
        let random3 = Int.random(in: 12..<18)
        
        let first = Thing.allCases[random1].parameter
        let second = Thing.allCases[random2].parameter
        let third = Thing.allCases[random3].parameter
    
        return [first,second,third]
    }
}

