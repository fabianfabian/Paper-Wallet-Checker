//
//  HelloblockBalanceFetcher.swift
//  Paper Wallet Checker
//
//  Created by Fabian Lachman on 25/04/15.
//  Copyright (c) 2015 Fabian Lachman. All rights reserved.
//

import Foundation
import SwiftyJSON

class HelloblockBalanceFetcher : BalanceFetcher
{
    
    override func fetch(address: String) {
        
        let urlPath = "https://mainnet.helloblock.io/v1/addresses/\(address)"
        let url = NSURL(string: urlPath)
        if (url == nil) { return } 
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {
            data, response, error in
            
            let json = JSON(data: data)
            if let balance = json["data"]["address"]["balance"].double {
                //            let balance = json["data"]["address"]["confirmedBalance"].floatValue
                let balanceBtc = balance / 100000000
                
                self.delegate?.didReceiveBalance("\(balanceBtc)", scanCounter:self.scanCounter, sender: self)
            }
        })
        
        task.resume()
    }
    
    
}