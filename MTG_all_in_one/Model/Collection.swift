//
//  Collection.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 16.11.22.
//

import Foundation
import RealmSwift


class CardCollection: Object, Codable {
    @objc dynamic var collectionName = ""
    var cards = List<CardMTG>()
}
