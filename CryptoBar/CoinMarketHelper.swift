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
    private let realmHelper = RealmHelper()
    
    func getEthereumPrice(){
        Alamofire.request(.GET, "https://coinmarketcap.com/currencies/ethereum/").responseString{ response in
            
            if let value = response.result.value{
                guard let eth_usd = self.scrapeEtherPrice(value) else{
                    return
                }
                self.realmHelper.savePrice("ETH", price: eth_usd)
                self.realmHelper.changeUSDT_ETHlast(eth_usd)
            }
            
        }
    }
    
    func getBitcoinPrice(){
        Alamofire.request(.GET, "https://coinmarketcap.com/currencies/bitcoin/").responseString{ response in
            
            if let value = response.result.value{
                guard let btc_usd = self.scrapePrice(value) else{
                    return
                }
                self.realmHelper.savePrice("BTC", price: btc_usd)
                self.realmHelper.changeUSDT_BTClast(btc_usd)
            }
            
        }
    }
    
    private func scrapePrice(html: String) -> Float?{
        var html = html
        let pos = html.rangeOfString("<span class=\"text-large\">$")
        html.removeRange(html.startIndex..<(pos?.endIndex.advancedBy(1))!)
        let price = html[html.startIndex..<html.startIndex.advancedBy(6)]
        guard let number = Float(price) else{
            return nil
        }
        return number
    }
    
    private func scrapeEtherPrice(html: String) -> Float?{
        var html = html
        let pos = html.rangeOfString("<span class=\"text-large\">$")
        html.removeRange(html.startIndex..<(pos?.endIndex.advancedBy(1))!)
        var price = html[html.startIndex..<html.startIndex.advancedBy(5)]
        if Float(price) == nil {
            price.removeAtIndex(price.endIndex.predecessor())
        }
        guard let number = Float(price) else{
            return nil
        }
        return number
    }
    
}