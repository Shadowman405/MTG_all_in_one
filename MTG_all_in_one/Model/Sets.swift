//
//  Sets.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 16.03.23.
//

import Foundation

class Sets: Codable {
    let sets: [Set]
    
    init(sets: [Set]) {
        self.sets = sets
    }
}

class Set: Codable {
    let code, name, type: String
    let releaseDate, block: String
    let onlineOnly: Bool

    init(code: String, name: String, type: String, releaseDate: String, block: String, onlineOnly: Bool) {
        self.code = code
        self.name = name
        self.type = type
        self.releaseDate = releaseDate
        self.block = block
        self.onlineOnly = onlineOnly
    }
}
