//
//  AdvancedSearchViewModel.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 21.03.23.
//

import Foundation

protocol AdvancedSearchViewModelProtocol {
    var setsMTG: [SetMTG] {get}
    
    func fetchSets(url: String, completion: @escaping () -> Void)
}

class AdvancedSearchViewModel: AdvancedSearchViewModelProtocol {
    var setsMTG: [SetMTG] = []
    
    func fetchSets(url: String, completion: @escaping () -> Void) {
        NetworkManager.shared.fetchSets(url: url) { sets in
            self.setsMTG = sets
            completion()
        }
    }
    
}
