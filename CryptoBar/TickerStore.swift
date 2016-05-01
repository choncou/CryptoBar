//
//  Ticker.swift
//  CryptoBar
//
//  Created by Unathi Chonco on 2016/04/28.
//  Copyright © 2016 Unathi Chonco. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

/// Object to store information about Ticker received from CoinMarkeyCap.com
class TickerStore: Object {

    dynamic var id = ""
    dynamic var name = ""
    dynamic var symbol = ""
    dynamic var rank: Int = 0
    dynamic var price: Float = 0.0
    dynamic var percent_change_24h: Float = 0.0
    
    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.symbol = json["symbol"].stringValue
        self.rank = json["rank"].intValue
        self.price = json["price_usd"].floatValue
        self.percent_change_24h = json["percent_change_24h"].floatValue
    }

    /**
     Set Properties to be indexed
     */
    override static func indexedProperties() -> [String] {
        return ["symbol"]
    }
    
    /**
     Set Primary Key
     */
    override static func primaryKey() -> String? {
        return "id"
    }
}
