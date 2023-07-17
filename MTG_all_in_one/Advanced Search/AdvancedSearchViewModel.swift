//
//  AdvancedSearchViewModel.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 21.03.23.
//

import Foundation

protocol AdvancedSearchViewModelProtocol {
    var searchSetValue: String {get set}
    var searchSetSegmentValue: String {get set}
    var setsMTG: [SetMTG] {get}
    var subtypesMTG: [Subtypes] {get}
    
    func fetchSets(url: String, completion: @escaping () -> Void)
    func fetchSubtypes(url: String, completion: @escaping () -> Void)
    func numberOfRows() -> Int
}

class AdvancedSearchViewModel: AdvancedSearchViewModelProtocol {
    var searchSetValue = ""
    var searchSetSegmentValue = "&set="
    var setsMTG: [SetMTG] = []
    var subtypesMTG: [Subtypes] = []
    
    
    //MARK: - Funcs
    
    func fetchSets(url: String, completion: @escaping () -> Void) {
        NetworkManager.shared.fetchSets(url: url) { sets in
            self.setsMTG = sets
            //print("\(self.setsMTG[0].name)")
            completion()
        }
    }
    
    func fetchSubtypes(url: String, completion: @escaping () -> Void) {
        NetworkManager.shared.fetchSubtypes(url: url) { subtypes in
            self.subtypesMTG = subtypes
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        if subtypesMTG.isEmpty {
            return 1
        } else {
            return subtypesMTG[0].subtypes.count
        }
    }
}
