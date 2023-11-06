//
//  CardGeneric.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 6.11.23.
//

import Foundation

struct CardMtgGen: Codable {
    var name: String
    var type: String
    var rarity: String
    var setName: String
    var imageURL: String
    var manaCost: String
    var text: String
    var originalType: String
    var id: String
}
