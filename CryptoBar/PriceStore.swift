//
//  PriceStore.swift
//  CryptoBar
//
//  Created by Unathi Chonco on 2016/04/18.
//  Copyright © 2016 Unathi Chonco. All rights reserved.
//

import Foundation
import RealmSwift

/// Realm Object for storing prices of currencies
class PriceStore: Object {
    
        /// Name of currency/coin - Primary Key adn Index
    dynamic var currencyName = ""
        /// latest stored price in USD
    dynamic var price: Float = 0.0
        /// latest stored price in BTC
    dynamic var btcValue: Float = 0.0
    
    /**
     Set Properties to be indexed
     */
    override static func indexedProperties() -> [String] {
        return ["currencyName"]
    }
    
    /**
     Set Primary Key
     */
    override static func primaryKey() -> String? {
        return "currencyName"
    }
}
