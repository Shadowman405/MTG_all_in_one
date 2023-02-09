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
    
    //func numberRows() -> Int
    func numberOfSections() -> Int
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
//    func numberRows() -> Int {
//        <#code#>
//    }
}
