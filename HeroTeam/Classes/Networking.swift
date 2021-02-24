//
//  Networking.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 20.02.2021.
//

import Foundation
import Alamofire

class Networking {
    
    private static let urlHeroesString = "https://www.breakingbadapi.com/api/characters"
    
    static var heroes: [Hero]? = [] {
        
        didSet {
            
            var someHeroes: [Hero]? = []
            
            heroes?.enumerated().forEach { hero in
                
                var someHero = hero.element
                someHero.heroUuid = UUID().uuidString
                someHero.quote = Quote.getRandom()
                someHero.things = Thing.getRandom()
                someHeroes?.append(someHero)
            }
            
            heroes = someHeroes
        }
    }
    
    static func getInfo() {
        
        DispatchQueue.global().async {
            
            AF.request(urlHeroesString, method: .get).response { response in
                
                let decoder = JSONDecoder()
                
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                guard let data = response.data else { return }
                
                self.heroes =  try? decoder.decode([Hero].self, from: data)
            }
        }
    }
}
