//
//  CollectionsViewModel.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 7.02.23.
//

import Foundation
import RealmSwift

protocol CollectionsViewModelProtocol {
    var cardCollection : Results<CardCollection>! {get}
    var selectedCollection: CardCollection? {get}
    
    func numberOfRows() -> Int
    func collectionViewModel(at indexPath: IndexPath) -> CardsInCollectionViewModelProtocol
}

class CollectionsViewModel: CollectionsViewModelProtocol {
    var cardCollection: RealmSwift.Results<CardCollection>! {
        StorageManager.shared.realm.objects(CardCollection.self)
    }
    
    var selectedCollection: CardCollection?
    
    func numberOfRows() -> Int {
        cardCollection.count
    }
    
    func collectionViewModel(at indexPath: IndexPath) -> CardsInCollectionViewModelProtocol {
        let collection = cardCollection[indexPath.row]
        return CardsInCollectionViewModel(collection: collection)
    }
    
}
