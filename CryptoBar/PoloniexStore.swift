//
//  PoloniexStore.swift
//  MyCrypto
//
//  Created by Unathi Chonco on 2016/03/14.
//  Copyright © 2016 Unathi Chonco. All rights reserved.
//

import Foundation
import RealmSwift

class PoloniexStore: Object {
    
    dynamic var title = ""
    dynamic var baseVolume: Float = 0.0
    dynamic var high24hr: Float = 0.0
    dynamic var highestBid: Float = 0.0
    dynamic var isFrozen: Float = 0.0
    dynamic var last: Float = 0.0
    dynamic var low24hr: Float = 0.0
    dynamic var lowestAsk: Float = 0.0
    dynamic var percentChange: Float = 0.0
    dynamic var quoteVolume: Float = 0.0
    
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
