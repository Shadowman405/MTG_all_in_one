//
//  CardCollectionCellViewModel.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 2.02.23.
//

import Foundation

protocol CardCollectionCellViewModelProtocol {
    var cardImg: String {get}
    
    init(card: CardMTG)
}

class CardCollectionCellViewModel:CardCollectionCellViewModelProtocol {
    private let card : CardMTG
    
    var cardImg: String {
        card.imageURL
    }
    
    required init(card: CardMTG) {
        self.card = card
    }
    
    
}
