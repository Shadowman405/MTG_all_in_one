//
//  CardsCollectionViewModel.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 29.01.23.
//

import Foundation

protocol CardCollectionViewModelProtocol {
    var cards: [CardMTG] { get }
    
    
    func fetchCards(completion: @escaping () -> Void)
    
    func numberOfRows() -> Int
}

class CardCollectionViewModel: CardCollectionViewModelProtocol {
    var cards: [CardMTG] = []
    
    func fetchCards(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchCards(url: "https://api.magicthegathering.io/v1/cards?page=311") { cards in
            self.cards = cards
        }
    }
    
    func numberOfRows() -> Int {
        cards.count
    }
    
    
}
