//
//  RealmHelper.swift
//  CryptoBar
//
//  Created by Unathi Chonco on 2016/04/18.
//  Copyright © 2016 Unathi Chonco. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    static var sharedInstance = RealmHelper()
    let realm = try! Realm()
    
    func savePrice(currency: Currencies, price: Float, btcValue: Float) {
        let priceStore = PriceStore()
        priceStore.currencyName = currency.rawValue
        priceStore.price = price
        priceStore.btcValue = btcValue
        try! realm.write({ 
            realm.add(priceStore, update: true)
        })
    }
    
    /**
     Get the price of any currency saved in the realm
     
     - parameter currency: currency that needs to be fetched
     
     - returns: PriceStore object of currency's price
     */
    func getPrice(currency: Currencies) -> PriceStore? {
        let price = realm.objects(PriceStore).filter("currencyName = '\(currency.rawValue)'")
        return price.first
    }
}