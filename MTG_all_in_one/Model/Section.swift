//
//  Section.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 18.02.23.
//

import Foundation

class Section {
    var title: String
    var duplicateCards: [CardMTG]
    var isOpened = false
    
    init(title: String, duplicateCards: [CardMTG], isOpened: Bool = false) {
        self.title = title
        self.duplicateCards = duplicateCards
        self.isOpened = isOpened
    }
}
