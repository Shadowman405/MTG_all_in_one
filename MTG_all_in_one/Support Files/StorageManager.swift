//
//  StorageManager.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 16.11.22.
//

import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    
    let realm = try! Realm()
    
    private init() {}
    
    //MARK: - Saving collection
    func save(cardCollection: [CardCollection]) {
        write {
            realm.add(cardCollection)
        }
    }
    
    
    func save(cardCollection: CardCollection) {
        write {
            realm.add(cardCollection)
        }
        
        //MARK: - Saving card to Collection
        
        func save(card: CardMTG, in cardCollectio: CardCollection){
            write {
                cardCollection.cards.append(card)
            }
        }
    }
    
    private func write(_ completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
