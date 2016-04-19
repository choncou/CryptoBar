//
//  CoinMarketHelper.swift
//  MyCrypto
//
//  Created by Unathi Chonco on 2016/03/15.
//  Copyright © 2016 Unathi Chonco. All rights reserved.
//

import Foundation
import Alamofire

class CoinMarketHelper{
    let realmHelper = RealmHelper.sharedInstance
    
    /**
     get and save latest price of Ether
     */
    func getEthereumPrice(){
        Alamofire.request(.GET, "https://coinmarketcap.com/currencies/ethereum/").responseString{ response in
            
            if let value = response.result.value{
                guard let eth_usd = self.scrapePrice(value) else{
                    return
                }
                guard let eth_btc = self.scrapeBTCValue(value) else{
                    return
                }
                self.realmHelper.savePrice(.ETH, price: eth_usd, btcValue: eth_btc)
            }
            
        }
    }
    
    /**
     Get and save th latest price of Bitcoin
     */
    func getBitcoinPrice(){
        Alamofire.request(.GET, "https://coinmarketcap.com/currencies/bitcoin/").responseString{
            response in
            
            if let value = response.result.value{
                guard let btc_usd = self.scrapePrice(value) else{
                    return
                }
                self.realmHelper.savePrice(.BTC, price: btc_usd, btcValue: 1)
            }
            
        }
    }
    
    /**
     Scrape the price of a currency
     
     - parameter html: html body of currencies page
     
     - returns: the price of the currency
     */
    private func scrapePrice(html: String) -> Float?{
        var html = html
        var pos = html.rangeOfString("<span class=\"text-large\">$ ")
        html.removeRange(html.startIndex..<(pos?.endIndex)!)
        pos = html.rangeOfString("</span>")
        let price = html[html.startIndex..<(pos?.startIndex)!]
        guard let number = Float(price) else{
            return nil
        }
        return number
    }
    
    /**
     Scrape the bitcoin value of a currency
     
     - parameter html: html body of currencies page
     
     - returns: the bitcoin value of the currency
     */
    private func scrapeBTCValue(html: String) -> Float?{
        var html = html
        var pos = html.rangeOfString("<small class=\"text-gray\">")
        html.removeRange(html.startIndex..<(pos?.endIndex)!)
        pos = html.rangeOfString(" BTC")
        let price = html[html.startIndex..<(pos?.startIndex)!]
        guard let number = Float(price) else{
            return nil
        }
        return number
    }
    
}