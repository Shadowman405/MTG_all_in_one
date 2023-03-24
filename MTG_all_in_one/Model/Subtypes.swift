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
    
    static func getAllSubtypes(from value: Any) -> [Subtypes]? {
        guard let value = value as? [String:Any] else {
            print(value)
            return []}
        guard let results = value as? [Subtypes] else {return []}
        return results
    }
}
