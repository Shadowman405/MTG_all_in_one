//
//  Supertypes.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 19.07.23.
//

import Foundation

class Supertypes: Codable {
    let supertypes: [String]

    init(supertypes: [String]) {
        self.supertypes = supertypes
    }
    
    static func getAllSubtypes(from value: Any) -> [Supertypes]? {
        guard let value = value as? [String:Any] else { return []}
        guard let results = value as? [String:Any] else {return []}
         //return results.compactMap { Subtypes(subtypes: $0)}
        var arrRes = [[String]]()
        for (_,val) in results {
            arrRes.append(val as? [String] ?? [""])
        }
        return [Supertypes(supertypes: arrRes[0])]
     }
}
