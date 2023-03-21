//
//  Sets.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 16.03.23.
//

import Foundation

//class Sets: Codable {
//    let sets: [SetMTG]
//    
//    init(sets: [SetMTG]) {
//        self.sets = sets
//    }
//}

class SetMTG: Codable {
    var code, name, type: String
    var releaseDate, block: String
    //var onlineOnly: Bool

//    init(code: String, name: String, type: String, releaseDate: String, block: String, onlineOnly: Bool) {
//        self.code = code
//        self.name = name
//        self.type = type
//        self.releaseDate = releaseDate
//        self.block = block
//        self.onlineOnly = onlineOnly
//    }
    
    init(setsData: [String:Any]) {
        name = setsData["name"] as? String ?? ""
        code = setsData["code"] as? String ?? ""
        type = setsData["type"] as? String ?? ""
        releaseDate = setsData["releaseDate"] as? String ?? ""
        block = setsData["block"] as? String ?? ""
        //onlineOnly = setsData["onlineOnly"] as? Bool ?? false
    }
    
    static func getAllSets(from value: Any) -> [SetMTG]? {
        guard let value = value as? [String: Any] else { return []}
        guard let results = value["sets"] as? [[String: Any]] else {return []}
        return results.compactMap { SetMTG(setsData: $0)}
    }
}
