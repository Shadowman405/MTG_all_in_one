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
}

class CollectionsViewModel: CollectionsViewModelProtocol {
    var cardCollection: RealmSwift.Results<CardCollection>! {
        StorageManager.shared.realm.objects(CardCollection.self)
    }
    
    var selectedCollection: CardCollection?
    
    func numberOfRows() -> Int {
        cardCollection.count
    }
    
}
