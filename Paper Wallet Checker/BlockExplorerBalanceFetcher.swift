//
//  BlockExplorerBalanceFetcher.swift
//  Paper Wallet Checker
//
//  Created by Fabian Lachman on 25/04/15.
//  Copyright (c) 2015 Fabian Lachman. All rights reserved.
//

import Foundation
import SwiftyJSON

class BlockExplorerBalanceFetcher : BalanceFetcher
{
    
    override func fetch(address: String) {
        
        let urlPath = "https://blockexplorer.com/q/addressbalance/\(address)/1" // /1 = 1 conf, /6 = 6 conf
        let url = NSURL(string: urlPath)
        if (url == nil) { return }
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {
            data, response, error in
            
            let balance = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            println("balance: \(balance) data: \(data) response: \(response)")
            
            if let balanceBtc = balance?.doubleValue {
                self.delegate?.didReceiveBalance("\(balanceBtc)", scanCounter:self.scanCounter, sender:self)
            }
        })
        
        task.resume()
    }
    
    
}