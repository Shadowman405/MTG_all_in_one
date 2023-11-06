//
//  CardGeneric.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 6.11.23.
//

import Foundation

//struct CardMtgGenResponse: Codable {
//    let cards: [CardMtgGen]
//}
//
//struct CardMtgGen: Codable {
//    var name: String
//    var type: String
//    var rarity: String
//    var setName: String
//    var imageURL: String
//    var manaCost: String
//    var text: String
//    var originalType: String
//    var id: String
//}


// MARK: - Welcome
struct CardMtgGenResponse: Codable {
    let cards: [Card]?
}

// MARK: - Card
struct Card: Codable {
    let name, manaCost: String?
    let cmc: Int?
    let colors, colorIdentity: [String]?
    let type: String?
    let types, subtypes: [String]?
    let rarity, cardSet, setName, text: String?
    var flavor, artist, number, power: String?
    let toughness, layout, multiverseid: String?
    let imageURL: String?
    let rulings: [Ruling]?
    let foreignNames: [ForeignName]?
    let printings: [String]?
    let originalText, originalType: String?
  //  let legalities: [LegalityElement]?
    let id: String?
    let variations: [String]?

    enum CodingKeys: String, CodingKey {
        case name, manaCost, cmc, colors, colorIdentity, type, types, subtypes, rarity
        case cardSet = "set"
        case setName, text, flavor, artist, number, power, toughness, layout, multiverseid
        case imageURL = "imageUrl"
        //case rulings, foreignNames, printings, originalText, originalType, legalities, id, variations
        case rulings, foreignNames, printings, originalText, originalType, id, variations

    }
}

// MARK: - ForeignName
struct ForeignName: Codable {
    let name, text, type, flavor: String?
    let imageURL: String?
    let language: String?
    let multiverseid: Int?

    enum CodingKeys: String, CodingKey {
        case name, text, type, flavor
        case imageURL = "imageUrl"
        case language, multiverseid
    }
}

// MARK: - LegalityElement
//struct LegalityElement: Codable {
//    let format: String?
//    let legality: LegalityEnum?
//}
//
//enum LegalityEnum: String, Codable {
//    case legal = "Legal"
//    case restricted = "Restricted"
//}

// MARK: - Ruling
struct Ruling: Codable {
    let date, text: String?
}
