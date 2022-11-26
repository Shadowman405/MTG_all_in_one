//
//  Card.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 14.11.22.
//

import Foundation
import RealmSwift

class CardMTG: Codable {
    var name: String
//    let cmc: Int
//    let colorIdentity: [String]
    var type: String
    var rarity: String
    var setName: String
    var imageURL: String
    var manaCost: String
    var text: String
//    let foreignNames: [ForeignName]
//    let printings: [String]
    var originalType: String
//    let legalities: [LegalityElement]
    var id: String
    
    init?(cardData: [String: Any]) {
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
