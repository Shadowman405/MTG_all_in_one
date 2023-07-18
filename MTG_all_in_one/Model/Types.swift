//
//  Types.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 18.07.23.
//

import Foundation

class Types: Codable {
    let types: [String]

    init(types: [String]) {
        self.types = types
    }
    
    static func getAllSubtypes(from value: Any) -> [Types]? {
        guard let value = value as? [String:Any] else { return []}
        guard let results = value as? [String:Any] else {return []}
         //return results.compactMap { Subtypes(subtypes: $0)}
        var arrRes = [[String]]()
        for (_,val) in results {
            arrRes.append(val as? [String] ?? [""])
        }
        return [Types(types: arrRes[0])]
     }
}
