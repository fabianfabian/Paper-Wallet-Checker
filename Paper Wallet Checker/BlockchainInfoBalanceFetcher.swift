//
//  BlockchainInfoBalanceFetcher.swift
//  Paper Wallet Checker
//
//  Created by Fabian Lachman on 25/04/15.
//  Copyright (c) 2015 Fabian Lachman. All rights reserved.
//

import Foundation

class BlockchainInfoBalanceFetcher : BalanceFetcher
{
    var confirmations = 0
    
    override func fetch(address: String) {

            let urlPath = "https://blockchain.info/q/addressbalance/\(address)?confirmations=\(confirmations)"
            let url = NSURL(string: urlPath)
            if (url == nil) { return } 
            let session = NSURLSession.sharedSession()
            println(urlPath)
            let task = session.dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
//                println(response)
//                if (error != nil) {
//                    // If there is an error in the web request, print it to the console
//                    println(error.localizedDescription)
//                }
                
                let balance = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
                
                let numberFormatter = NSNumberFormatter()
                let number = numberFormatter.numberFromString(balance)
                if let numberFloatValue = number?.doubleValue {
                    let balanceBtc = numberFloatValue / 100000000
                    self.delegate?.didReceiveBalance("\(balanceBtc)", scanCounter:self.scanCounter, sender:self)
                }
            })
            task.resume()
    }
    
}