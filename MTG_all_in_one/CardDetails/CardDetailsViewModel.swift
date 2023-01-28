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
    
    init(card: CardMTG)
}

class CardDetailsViewModel: CardDetailsViewModelProtocol {
    var cardName: String {
        card.name
    }
    
    var setName: String {
        card.setName
    }
    
    var cardRarity: String {
        card.rarity
    }
    
    var manaCost: String {
        card.manaCost
    }
    
    var descriptionText: String {
        card.description
    }
    
    var cardImage: String {
        card.imageURL // need to create cardImageModelView - and work with new VM
    }
    
    private let card: CardMTG
    
    required init(card: CardMTG) {
        self.card = card
    }
    
    
}
