//
//  CardsInCollectionViewModel.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 5.02.23.
//

import Foundation

protocol CardsInCollectionViewModelProtocol {
    var card: CardMTG {get}
    var collection: CardCollection {get}
    var editable: Bool {get set}
    
    init(collection: CardCollection)
    
    func numberOfSections() -> Int
    func numberOfRows(section: Int) -> Int
    func titleForHeader(section: Int) -> String?
}

class CardsInCollectionViewModel: CardsInCollectionViewModelProtocol {
    var editable: Bool = true
    var card: CardMTG = CardMTG()
    var collection: CardCollection
    
    required init(collection: CardCollection) {
        self.collection = collection
    }
    
    func numberOfSections() -> Int {
        if editable {
            return 2
        } else {
            return 1
        }
    }
    
    func titleForHeader(section: Int) -> String? {
        if editable {
            if section == 0 {
                return "Main Deck"
            } else {
                return "Side Deck"
            }
        } else {
            if section == 0 {
                return "\(collection.collectionName)"
            } else {
                return "Deck"
            }
        }
    }
    
    func numberOfRows(section: Int) -> Int {
        if editable {
            if section == 0 {
                if (collection.cards.count) <= 59{
                    return collection.cards.count
                } else {
                    return collection.cards[0...59].count
                }
            } else {
                if (collection.cards.count) > 59 {
                    return collection.cards[59...collection.cards.count - 1].count
                } else {
                    return 0
                }
            }
        } else {
            return collection.cards.count
        }
    }
}
