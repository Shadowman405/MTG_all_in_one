//
//  CardsCollectionViewModel.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 29.01.23.
//

import Foundation
import Algorithms

protocol CardCollectionViewModelProtocol {
    var cards: [CardMTG] { get }
    
    func fetchCards(url: String, completion: @escaping () -> Void)
    func numberOfRows() -> Int
    
    func cellViewModel(at indexPath: IndexPath) -> CardCollectionCellViewModelProtocol
    func detailsViewModel(at indexPath: IndexPath) -> CardDetailsViewModelProtocol
    func frameSize(width: CGFloat) -> CGSize
}

class CardCollectionViewModel: CardCollectionViewModelProtocol {
    var cards: [CardMTG] = []
    
    func fetchCards(url: String, completion: @escaping () -> Void) {
        NetworkManager.shared.fetchCards(url: url) { cards in
            var uniquedCards = [CardMTG]()
            for card in cards {
//                if !uniquedCards.contains(where: {$0.imageURL != "" && $0.name == card.name}){
//                    uniquedCards.append(card)
//                }
                    uniquedCards.append(card)
            }
            self.cards = uniquedCards.filter{$0.imageURL != ""}
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        cards.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CardCollectionCellViewModelProtocol {
        let card = cards[indexPath.row]
        return CardCollectionCellViewModel(card: card)
    }
    
    func detailsViewModel(at indexPath: IndexPath) -> CardDetailsViewModelProtocol {
        let card = cards[indexPath.row]
        return CardDetailsViewModel(card: card)
    }
    
    func frameSize(width: CGFloat) -> CGSize {
        let cellWidth = (width - 40) / 2
        let cellHeight = cellWidth * 1.5
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}
