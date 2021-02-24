//
//  Networking.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 20.02.2021.
//

import Foundation
import Alamofire

class Networking {
    
    static let decoder: JSONDecoder = {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private static let urlHeroesString = "https://www.breakingbadapi.com/api/characters"
    
    private static let urlQuoteString = "https://type.fit/api/quotes"
    
    static var quotes: [Quote]? = []
    
    static var heroes: [Hero]? = [] {
        
        didSet {
            
            var someHeroes: [Hero]? = []
            
            heroes?.enumerated().forEach { hero in
                
                var someHero = hero.element
                someHero.heroUuid = UUID().uuidString
                someHero.quote = quotes?.randomElement()?.text
                someHero.things = Thing.getRandom()
                someHeroes?.append(someHero)
            }
            
            heroes = someHeroes
        }
    }
    
    static func getInfo() {
        
        DispatchQueue.global().async {
            
            AF.request(urlHeroesString, method: .get).response { response in
                
                guard let data = response.data else { return }
                
                self.heroes =  try? decoder.decode([Hero].self, from: data)
            }
        }
    }
    
    static func getQuotes(completion: @escaping ()->()) {
        
        DispatchQueue.global().async {
            
            AF.request(urlQuoteString, method: .get).response { response in
                
                guard let data = response.data else { return }
                
                self.quotes =  try? decoder.decode([Quote].self, from: data)
                
                completion()
            }
        }
    }
}
