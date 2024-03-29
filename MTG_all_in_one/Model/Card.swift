//
//  Card.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 14.11.22.
//

import Foundation
import RealmSwift

class CardMTG: Object, Codable {
    @objc dynamic var name: String
//    let cmc: Int
//    let colorIdentity: [String]
    @objc dynamic var type: String
    @objc dynamic var rarity: String
    @objc dynamic var setName: String
    @objc dynamic var imageURL: String
    @objc dynamic var manaCost: String
    @objc dynamic var text: String
//    let foreignNames: [ForeignName]
//    let printings: [String]
    @objc dynamic var originalType: String
//    let legalities: [LegalityElement]
    @objc dynamic var id: String
    
    
    convenience init?(cardData: [String: Any]) {
        self.init()
        
        name = cardData["name"] as? String ?? ""
        type = cardData["type"] as? String ?? ""
        imageURL = cardData["imageUrl"] as? String ?? ""
        originalType = cardData["originalType"] as? String ?? ""
        id = cardData["id"] as? String ?? ""
        rarity = cardData["rarity"] as? String ?? ""
        manaCost = cardData["manaCost"] as? String ?? ""
        setName = cardData["setName"] as? String ?? ""
        text = cardData["text"] as? String ?? ""
    }
    
    
    static func getAllCards(from value: Any) -> [CardMTG]? {
        guard let value = value as? [String: Any] else { return []}
        guard let results = value["cards"] as? [[String: Any]] else {return []}
        return results.compactMap { CardMTG(cardData: $0) }
    }
}
