//
//  SaveCardViewModel.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 30.01.23.
//

import Foundation
import RealmSwift

protocol SaveCardViewModelProtocol {
    var card: CardMTG {get set}
    var collection: Results<CardCollection>! {get set}
    
    init(card: CardMTG)
    
    func loadCollcetions(completion: @escaping () -> Void)
    func saveInCollection(at indexPath: IndexPath)
    func numverOfRows() -> Int
}

class SaveCardViewModel: SaveCardViewModelProtocol {
    var card: CardMTG = CardMTG()
    var collection: RealmSwift.Results<CardCollection>!
    
    required init(card: CardMTG) {
        self.card = card
    }
    
    func loadCollcetions(completion: @escaping () -> Void) {
        collection = StorageManager.shared.realm.objects(CardCollection.self)
        completion()
    }
    
    func saveInCollection(at indexPath: IndexPath) {
        let collectionToSave = collection[indexPath.row]
        StorageManager.shared.save(card: card, in: collectionToSave)
    }
    
    func numverOfRows() -> Int {
        collection.count
    }
}

