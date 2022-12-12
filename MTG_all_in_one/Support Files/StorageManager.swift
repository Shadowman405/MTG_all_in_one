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
    
    //MARK: - Save/delete collection
    func save(cardCollection: [CardCollection]) {
        write {
            realm.add(cardCollection)
        }
    }
    
    func save(cardCollection: CardCollection) {
        write {
            realm.add(cardCollection)
        }
    }
    
    func delete(cardCollection: CardCollection) {
        write {
            realm.delete(cardCollection.cards)
            realm.delete(cardCollection)
        }
    }
    
    //MARK: - Save CArd
    
    func save(card: CardMTG,in cardCollection: CardCollection){
        write {
            cardCollection.cards.append(card)
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
