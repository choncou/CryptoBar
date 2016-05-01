//
//  CoinMarketHelper.swift
//  MyCrypto
//
//  Created by Unathi Chonco on 2016/03/15.
//  Copyright © 2016 Unathi Chonco. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CoinMarketHelper{
    let realmHelper = RealmHelper()
    
    /**
     get and save latest price of Ether
     */
    func getAllPrices(){
        Alamofire.request(.GET, "https://api.coinmarketcap.com/v1/ticker/").responseJSON{
            response in
            
            if let value = response.result.value{
                let json = JSON(value)
                self.realmHelper.saveAllTickers(json)
            }
            
        }
    }
    
}