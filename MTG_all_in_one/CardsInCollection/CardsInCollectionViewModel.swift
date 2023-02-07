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
    
    
}

class CardsInCollectionViewModel: CardsInCollectionViewModelProtocol {
    var card: CardMTG = CardMTG()
    var collection: CardCollection = CardCollection()
    
    
}
