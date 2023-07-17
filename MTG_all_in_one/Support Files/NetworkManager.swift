//
//  NetworkManager.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 14.11.22.
//
import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    static let shared = NetworkManager()
    let urlMTG = "https://api.magicthegathering.io/v1/cards?page=311"
    
    // For advanced search
    let types = ["artifact", "conspiracy", "creature", "dragon", "elemental", "enchantment", "goblin", "hero",
                 "instant", "jaguar", "knights", "land", "phenomenon" , "plane" , "planeswalker", "scheme",
                 "sorcery", "stickers", "summon", "tribal", "universewalker", "vanguard", "wolf"
    ]
    
    let supertypes = ["basic", "host", "legendary", "ongoing", "snow", "world"]
    let formats = ["Alchemy", "Brawl", "Commander", "Duel", "Explorer", "Future", "Gladiator", "Historic", "Historicbrawl", "Legacy", "Modern", "Oldschool", "Pauper", "Paupercommander", "Penny", "Pioneer", "Predh", "Premodern", "Standard", "Vintage"
      ]
    
    
    //MARK: - Mock data
    var mockSetArr : [SetMTG] = [SetMTG(code: "", name: "Waiting for data", type: "", releaseDate: "", block: "", onlineOnly: false)]
    var mockSubtypesArr : [Subtypes] = [Subtypes(subtypes: ["Waiting for data"])]
    
    let sets = [String]() // need fetch data from API
    let subtypes = [String]() // need fetch data from API
    
    
    func fetchCards(url: String, with completion: @escaping ([CardMTG]) -> ()) {
        AF.request(url, method: .get).validate().responseJSON { responseData in
            switch responseData.result {
            case .success(let value):
                guard let cardData = CardMTG.getAllCards(from: value) else {return}
                
                DispatchQueue.main.async {
                    completion(cardData)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - fetching settings for advanced searc
    
    func fetchSets(url: String, with completion: @escaping ([SetMTG]) -> ()) {
        AF.request(url, method: .get).validate().responseJSON { respaonseData in
            switch respaonseData.result {
            case .success(let value):
                guard let setsData = SetMTG.getAllSets(from: value) else {return}
                
                DispatchQueue.main.async {
                    completion(setsData)
                }
            case .failure(let error):
                            print(error.localizedDescription)
            }
        }
    }
    
    //subtypes
    func fetchSubtypes(url: String, with completion: @escaping ([Subtypes]) -> ()) {
        AF.request(url, method: .get).validate().responseJSON { respaonseData in
            switch respaonseData.result {
            case .success(let value):
                guard let subtypesData = Subtypes.getAllSubtypes(from: value) else {return}
                DispatchQueue.main.async {
                    completion(subtypesData)
                }
            case .failure(let error):
                            print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Change mana cost string to images
    func addManaImages(someString: String?) -> NSMutableAttributedString {
        guard let manaCost = someString else {return NSMutableAttributedString()}
        let imagesDict: [String:String] = ["{W}":"W", "{R}":"R","{B}":"B","{G}":"G","{U}":"U", "{1}":"One", "{2}":"Two", "{3}":"Three",
                                           "{4}":"Four", "{5}":"Five", "{6}":"Six", "{7}":"Seven", "{8}":"Eight", "{9}":"Nine", "{0}":"Zero",
                                           "{T}":"T_2nd", "{G/W}":"GW", "{G/U}":"GU", "{W/B}":"WB", "{W/U}":"WU", "{X}":"X", "{U/B}":"UB", "{B/R}":"BR", "{R/G}":"RG", "{U/R}":"UR", "{B/G}":"BG", "{R/W}":"RW",
                                           "{2/W}":"2W", "{2/U}":"2U", "{2/B}":"2B", "{2/R}":"2R"
        ]
        let fullString = NSMutableAttributedString(string: manaCost)
        
        for (imageTag, imageName) in imagesDict {
            let pattern = NSRegularExpression.escapedPattern(for: imageTag)
            let regex = try? NSRegularExpression(pattern: pattern,
                                                 options: [])
            if let matches = regex?.matches(in: fullString.string, range: NSRange(location: 0, length: fullString.string.utf16.count)) {
                for aMtach in matches.reversed() {
                    let attachment = NSTextAttachment()
                    attachment.image = UIImage(named: imageName)
                    attachment.bounds = CGRectMake(0, 0, 24, 24)
                    let replacement = NSAttributedString(attachment: attachment)
                    fullString.replaceCharacters(in: aMtach.range, with: replacement)
                }
            }
        }
        
        return fullString
        
    }
}


class ImageManager {
    static var shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping (Data,URLResponse) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {print(error?.localizedDescription ?? "Error, no description")
                return
            }
            completion(data, response)
        }.resume()
    }
}





