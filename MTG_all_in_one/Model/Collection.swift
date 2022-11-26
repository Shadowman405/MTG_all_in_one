//
//  Collection.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 16.11.22.
//

import Foundation


class CardCollection: Codable {
    let collectionName: String
    let cards: [CardMTG]
    
    init(name: String, cards: [CardMTG]) {
        self.collectionName = name
        self.cards = cards
    }
}
