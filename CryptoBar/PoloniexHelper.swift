//
//  PoloniexHelper.swift
//  MyCrypto
//
//  Created by Unathi Chonco on 2016/03/14.
//  Copyright © 2016 Unathi Chonco. All rights reserved.
//

import Foundation
import Alamofire
import Gloss

class PoloniexHelper{
    private let poloniexUrl: String = "https://poloniex.com/tradingApi"
    private let realmHelper = RealmHelper()
    let cHelper = CoinMarketHelper()
    
    func returnTickers(){
        Alamofire.request(.GET, "https://poloniex.com/public", parameters: ["command": "returnTicker"]).responseJSON{ response in
            if let json = response.result.value{
                guard let allTickers = Tickers(json: json as! JSON) else{
                    return
                }
                self.realmHelper.saveTickers(allTickers)
                self.cHelper.getEthereumPrice()
                self.cHelper.getBitcoinPrice()
            }
            
            switch response.result{
            case .Success:
                print("Success")
            case .Failure:
                print(response.result.error)
            }
            
        }
    }
    
}
