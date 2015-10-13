//
//  BlockBalanceFetcher.swift
//  Paper Wallet Checker
//
//  Created by Fabian Lachman on 25/04/15.
//  Copyright (c) 2015 Fabian Lachman. All rights reserved.
//

import Foundation
import SwiftyJSON

class BlockBalanceFetcher : BalanceFetcher
{
    
    override func fetch(address: String) {
        let apiKey = valueForAPIKey(keyname:  "block.io")
        
        let urlPath = "https://block.io/api/v2/get_address_balance/?api_key=\(apiKey)&addresses=\(address)"
        let url = NSURL(string: urlPath)
        if (url == nil) { return } 
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {
            data, response, error in
            
            if (error != nil) {
                print("Error: \(error)");
                return;
            }
            
            let json = JSON(data: data!)
            let balance = json["data"]["available_balance"].stringValue
//            let balance = json["data"]["pending_received_balance"].stringValue

            self.delegate?.didReceiveBalance("\((balance as NSString).doubleValue)", scanCounter: self.scanCounter, sender: self)
        })
        
        task.resume()
    }
    
    
}