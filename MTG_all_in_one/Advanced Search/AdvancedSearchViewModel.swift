//
//  AdvancedSearchViewModel.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 21.03.23.
//

import Foundation

protocol AdvancedSearchViewModelProtocol {
    var searchSetValue: String {get set}
    var searchSubtypeValue: String {get set}
    var searchTypeValue: String {get set}
    var searchSupertypeValue: String {get set}
    var searchFormatValue: String {get set}
    
    var searchSetSegment: String {get set}
    var searchSubtypeSegment: String {get set}
    var searchTypeSegment: String {get set}
    var searchSupertypeSegment: String {get set}
    var searchFormatSegment: String {get set}
    
    var setsMTG: [SetMTG] {get}
    var subtypesMTG: [Subtypes] {get}
    var typesMTG: [Types] {get}
    var supertypesMTG: [Supertypes] {get}
    var formatsMTG: [Formats] {get}
    
    func fetchSets(url: String, completion: @escaping () -> Void)
    func fetchSubtypes(url: String, completion: @escaping () -> Void)
    func fetchTypes(url: String, completion: @escaping () -> Void)
    func fetchSupertypes(url: String, completion: @escaping () -> Void)
    func fetchFormats(url: String, completion: @escaping () -> Void)
    func numberOfRows(segmnetedControlIndex: Int) -> Int
}

class AdvancedSearchViewModel: AdvancedSearchViewModelProtocol {
    var searchSetValue = ""
    var searchSubtypeValue = ""
    var searchTypeValue = ""
    var searchSupertypeValue = ""
    var searchFormatValue = ""
    
    var searchSetSegment = "&set="
    var searchSubtypeSegment = "&subtypes="
    var searchTypeSegment = "&types="
    var searchSupertypeSegment = "&supertypes="
    var searchFormatSegment = "&format="
    
    var setsMTG: [SetMTG] = NetworkManager.shared.mockSetArr
    var subtypesMTG: [Subtypes] = NetworkManager.shared.mockSubtypesArr
    var typesMTG: [Types] = NetworkManager.shared.mockTypesArr
    var supertypesMTG: [Supertypes] = NetworkManager.shared.mockSupertypes
    var formatsMTG: [Formats] = NetworkManager.shared.mockFormats
    
    
    //MARK: - Fetching Funcs
    
    func fetchSets(url: String, completion: @escaping () -> Void) {
        NetworkManager.shared.fetchSets(url: url) { sets in
            self.setsMTG = sets
            completion()
        }
    }
    
    func fetchSubtypes(url: String, completion: @escaping () -> Void) {
        NetworkManager.shared.fetchSubtypes(url: url) { subtypes in
            self.subtypesMTG = subtypes
            completion()
        }
    }
    
    func fetchTypes(url: String, completion: @escaping () -> Void) {
        NetworkManager.shared.fetchTypes(url: url) { types in
            self.typesMTG = types
            completion()
        }
    }
    
    func fetchSupertypes(url: String, completion: @escaping () -> Void) {
        NetworkManager.shared.fetchSupertypes(url: url) { supertypes in
            self.supertypesMTG = supertypes
            completion()
        }
    }
    
    func fetchFormats(url: String, completion: @escaping () -> Void) {
        NetworkManager.shared.fetchFormats(url: url) { formats in
            self.formatsMTG = formats
            completion()
        }
    }
    
    
    //MARK: - Helpers
    
    func numberOfRows(segmnetedControlIndex: Int) -> Int {
        if segmnetedControlIndex == 0 {
            return setsMTG.count
        } else if segmnetedControlIndex == 1 {
            return subtypesMTG[0].subtypes.count
        } else if segmnetedControlIndex == 2 {
            return typesMTG[0].types.count
        } else if segmnetedControlIndex == 3 {
            return supertypesMTG[0].supertypes.count
        } else if segmnetedControlIndex == 4 {
            return formatsMTG[0].formats.count
        }
        else {
            return 1
        }
    }
}

