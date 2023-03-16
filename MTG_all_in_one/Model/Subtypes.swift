//
//  Subtypes.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 16.03.23.
//

import Foundation

class Subtypes: Codable {
    let subtypes: [String]

    init(subtypes: [String]) {
        self.subtypes = subtypes
    }
}
