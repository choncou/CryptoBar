//
//  Ticker.swift
//  MyCrypto
//
//  Created by Unathi Chonco on 2016/03/14.
//  Copyright © 2016 Unathi Chonco. All rights reserved.
//

import Foundation
import Gloss

struct Ticker: Decodable{
    let baseVolume: Float
    let high24hr: Float
    let highestBid: Float
    let isFrozen: Float
    let last: Float
    let low24hr: Float
    let lowestAsk: Float
    let percentChange: Float
    let quoteVolume: Float
    
    init?(json: JSON){
        guard let baseVolume: String = "baseVolume" <~~ json else {
            return nil
        }
        guard let high24hr: String = "high24hr" <~~ json
            else {
                return nil
        }
        guard let highestBid: String = "highestBid" <~~ json
            else { return nil}
        guard let isFrozen: String = "isFrozen" <~~ json
            else { return nil}
        guard let last: String = "last" <~~ json
            else { return nil}
        guard let low24hr: String = "low24hr" <~~ json
            else { return nil}
        guard let lowestAsk: String = "lowestAsk" <~~ json
            else { return nil}
        guard let percentChange: String = "percentChange" <~~ json
            else { return nil}
        guard let quoteVolume: String = "quoteVolume" <~~ json
            else { return nil}
        
        self.baseVolume = Float(baseVolume)!
        self.high24hr = Float(high24hr)!
        self.highestBid = Float(highestBid)!
        self.isFrozen = Float(isFrozen)!
        self.last = Float(last)!
        self.low24hr = Float(low24hr)!
        self.lowestAsk = Float(lowestAsk)!
        self.percentChange = Float(percentChange)!
        self.quoteVolume = Float(quoteVolume)!
    }
}


struct Tickers: Decodable{
    private var tickList = [String: Ticker]()
    
    init?(json: JSON) {
        let dict = json as NSDictionary
        let keys = dict.allKeys as! [String]
        
        for key in keys{
            guard let ticker: Ticker = key <~~ json else{
                return nil
            }
            //            key.removeRange(key.startIndex...key.startIndex.advancedBy(4))
            self.tickList[key] = ticker
        }
    }
    
    func getTicker(label: String) -> Ticker?{
        guard let ticker = self.tickList[label]
            else {return nil}
        return ticker
    }
    
    func getAllTickers() -> [String: Ticker]{
        return self.tickList
    }
}

