//
//  StorageManager.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 16.11.22.
//

import Foundation

class StorageManager {
    static let shared = NetworkManager()
    
    private let userDefaults = UserDefaults.standard
    private let collectionKey = "collection"
    
    private init() {}
    
    func fetchCollections() {
        // load data from UserDefaults
    }
    
    func saveCollection() {
        //saving to UserDefaults
    }
}
