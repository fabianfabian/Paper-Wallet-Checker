//
//  ChainBalanceFetcher.swift
//  Paper Wallet Checker
//
//  Created by Fabian Lachman on 25/04/15.
//  Copyright (c) 2015 Fabian Lachman. All rights reserved.
//

import Foundation
import SwiftyJSON

class ChainBalanceFetcher : BalanceFetcher
{
    
    override func fetch(address: String) {
                let apiKey = valueForAPIKey(keyname:  "chain.com")
        
        let urlPath = "https://api.chain.com/v2/bitcoin/addresses/\(address)?api-key-id=\(apiKey)"
        let url = NSURL(string: urlPath)
        if (url == nil) { return } 
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {
            data, response, error in
            
            let json = JSON(data: data)
            if let balance = json[0]["total"]["balance"].double {
                //            let balance = json["confirmed"]["balance"].floatValue
                let balanceBtc = balance / 100000000
                
                self.delegate?.didReceiveBalance("\(balanceBtc)", scanCounter:self.scanCounter, sender: self)
            }
        })
        
        task.resume()
    }
    
    
}