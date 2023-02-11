//
//  CardDetailsViewModel.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 28.01.23.
//

import Foundation


protocol CardDetailsViewModelProtocol {
    var cardName: String {get}
    var setName: String {get}
    var cardRarity: String {get}
    var manaCost: String {get}
    var descriptionText: String {get}
    var cardImage: String {get}
    var card: CardMTG {get}
    
    init(card: CardMTG)
}

class CardDetailsViewModel: CardDetailsViewModelProtocol {
    var cardName: String {
        card.name
    }
    
    var setName: String {
        "Set name: " + card.setName
    }
    
    var cardRarity: String {
        "Card rarity: " + card.rarity
    }
    
    var cardImage: String {
        card.imageURL
    }
    
    var manaCost: String {
        card.manaCost
    }
    
    var descriptionText: String {
        card.text
    }
    
    var card: CardMTG = CardMTG()
    
    required init(card: CardMTG) {
        self.card = card
    }
    
    
}
