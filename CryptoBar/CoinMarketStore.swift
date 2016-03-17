//
//  CoinMarketStore.swift
//  MyCrypto
//
//  Created by Unathi Chonco on 2016/03/15.
//  Copyright © 2016 Unathi Chonco. All rights reserved.
//

import Foundation
import RealmSwift

class CoinMarketStore: Object {
    
    dynamic var title = ""
    dynamic var price: Float = 0.0
    
    override static func indexedProperties() -> [String] {
        return ["title"]
    }
    
    override static func primaryKey() -> String? {
        return "title"
    }
    
    // Specify properties to ignore (Realm won't persist these)
    
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
}
