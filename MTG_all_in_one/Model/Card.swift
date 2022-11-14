//
//  Card.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 14.11.22.
//

import Foundation

struct CardMTG: Codable {
    let name: String
//    let cmc: Int
//    let colorIdentity: [String]
    let type: String
    let rarity: String
    let setName: String
    let imageURL: String
    let manaCost: String
    let text: String
//    let foreignNames: [ForeignName]
//    let printings: [String]
    let originalType: String
//    let legalities: [LegalityElement]
    let id: String
    
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
