//
//  RealmHelper.swift
//  CryptoBar
//
//  Created by Unathi Chonco on 2016/04/18.
//  Copyright © 2016 Unathi Chonco. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class RealmHelper {
    let realm = try! Realm()
    
    /**
     Save a ticker to Realm
     
     - parameter json: json of the ticker to be stored
     */
    func saveTicker(json: JSON) {
        let ticker = TickerStore(json: json)
        try! realm.write({
            realm.add(ticker, update: true)
        })
    }
    
    /**
     Save a collection of tickers to Realm
     
     - parameter json: json of the tickers to be stored
     */
    func saveAllTickers(json: JSON) {
        var tickers: [TickerStore] = []
        for ticker in json {
            tickers.append(TickerStore(json: ticker.1))
        }
        try! realm.write({
            for ticker in tickers {
                realm.add(ticker, update: true)
            }
        })
    }
    
    /**
     Get the price of any currency saved in the realm
     
     - parameter currency: currency that needs to be fetched
     
     - returns: PriceStore object of currency's price
     */
    func getPrice(currency: Currencies) -> TickerStore? {
        let price = realm.objects(TickerStore).filter("symbol = '\(currency.rawValue)'")
        return price.first
    }
}