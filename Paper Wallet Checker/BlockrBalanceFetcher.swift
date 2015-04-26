//
//  BlockrBalanceFetcher.swift
//  Paper Wallet Checker
//
//  Created by Fabian Lachman on 25/04/15.
//  Copyright (c) 2015 Fabian Lachman. All rights reserved.
//

import Foundation
import SwiftyJSON

class BlockrBalanceFetcher : BalanceFetcher
{
    
    override func fetch(address: String) {
        
        let urlPath = "http://btc.blockr.io/api/v1/address/info/\(address)"
        let url = NSURL(string: urlPath)
        if (url == nil) { return } 
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {
            data, response, error in
            
            let json = JSON(data: data)
            if let balance = json["data"]["balance"].double {
                self.delegate?.didReceiveBalance("\(balance)", scanCounter:self.scanCounter, sender: self)
            }
        })
        
        task.resume()
    }
    
}
