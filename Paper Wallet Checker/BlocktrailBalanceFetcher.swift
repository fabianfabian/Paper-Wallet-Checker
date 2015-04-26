//
//  BlocktrailBalanceFetcher.swift
//  Paper Wallet Checker
//
//  Created by Fabian Lachman on 25/04/15.
//  Copyright (c) 2015 Fabian Lachman. All rights reserved.
//

import Foundation
import SwiftyJSON

class BlocktrailBalanceFetcher : BalanceFetcher
{
    
    override func fetch(address: String) {
        let apiKey = valueForAPIKey(keyname:  "blocktrail.com")
        
        let urlPath = "https://api.blocktrail.com/v1/btc/address/\(address)?api_key=\(apiKey)"
        let url = NSURL(string: urlPath)
        if (url == nil) { return } 
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {
            data, response, error in
            
            let json = JSON(data: data)
            if let balance = json["balance"].double {
                let balanceBtc = balance / 100000000
                
                self.delegate?.didReceiveBalance("\(balanceBtc)", scanCounter:self.scanCounter, sender: self)
            }
        })
        
        task.resume()
    }
    
    
}