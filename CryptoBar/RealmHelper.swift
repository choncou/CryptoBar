//
//  RealmHelper.swift
//  MyCrypto
//
//  Created by Unathi Chonco on 2016/03/14.
//  Copyright © 2016 Unathi Chonco. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper{
    let realm = try! Realm()
    
    func saveTickers(tickers: Tickers){
        let tickerList = tickers.getAllTickers()
        
        for ticker in tickerList{
            let newTicker = PoloniexStore()
            newTicker.title = ticker.0
            newTicker.baseVolume = ticker.1.baseVolume
            newTicker.high24hr = ticker.1.high24hr
            newTicker.highestBid = ticker.1.highestBid
            newTicker.isFrozen = ticker.1.isFrozen
            newTicker.last = ticker.1.last
            newTicker.low24hr = ticker.1.lowestAsk
            newTicker.percentChange = ticker.1.percentChange
            newTicker.quoteVolume = ticker.1.quoteVolume
            
            try! realm.write{
                self.realm.add(newTicker, update: true)
            }
        }
        
    }
    
    func changeUSDT_ETHlast(price: Float){
        guard let ticker = realm.objects(PoloniexStore).filter("title = 'USDT_ETH'").first else{
            return
        }
        
        try! realm.write{
            ticker.last = price
        }
    }
    
    func changeUSDT_BTClast(price: Float){
        guard let ticker = realm.objects(PoloniexStore).filter("title = 'USDT_BTC'").first else{
            return
        }
        
        try! realm.write{
            ticker.last = price
        }
        
    }
    
    func getETHPrice() -> Float?{
        guard let eth = realm.objects(CoinMarketStore).filter("title = 'ETH'").first?.price else{
            return nil
        }
        return eth
    }
    
    func savePrice(title: String, price: Float){
        let newPrice = CoinMarketStore()
        newPrice.title = title
        newPrice.price = price
        
        try! realm.write{
            self.realm.add(newPrice, update: true)
        }
    }
}
