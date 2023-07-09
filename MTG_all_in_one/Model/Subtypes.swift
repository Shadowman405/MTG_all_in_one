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
        guard let value = value as? [String:Any] else { return []}
        guard let results = value as? [String:Any] else {return []}
         //return results.compactMap { Subtypes(subtypes: $0)}
        print(results)
        var arrRes = [[String]]()
        for (_,val) in results {
            arrRes.append(val as? [String] ?? [""])
        }
        return [Subtypes(subtypes: arrRes[0])]
     }
}
