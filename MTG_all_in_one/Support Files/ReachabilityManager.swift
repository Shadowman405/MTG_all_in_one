//
//  ReachabilityManager.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 17.08.23.
//

import Foundation
import Alamofire

struct Connectivity {
    static let shared = Connectivity()
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet: Bool {
        return self.sharedInstance.isReachable
    }
    
    func reacheable() -> Bool {
        let sharedInstance = NetworkReachabilityManager()!
            return  sharedInstance.isReachable
        }
    }

