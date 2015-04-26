//
//  BlockCypherBalanceFetcher.swift
//  Paper Wallet Checker
//
//  Created by Fabian Lachman on 25/04/15.
//  Copyright (c) 2015 Fabian Lachman. All rights reserved.
//

import Foundation
import SwiftyJSON

class BlockCypherBalanceFetcher : BalanceFetcher
{
    
    override func fetch(address: String) {

        let urlPath = "http://api.blockcypher.com/v1/btc/main/addrs/\(address)"
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