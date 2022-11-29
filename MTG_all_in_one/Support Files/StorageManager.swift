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
    
    func save(cardCollection: [CardCollection]) {
        try! realm.write {
            realm.add(cardCollection)
        }
    }
}
