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
            print(urlPath)
            let task = session.dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in

                if (error != nil) {
                    print("Error: \(error)");
                    return;
                }
                
                let balance = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
                
                let numberFormatter = NSNumberFormatter()
                let number = numberFormatter.numberFromString(balance)
                if let numberDoubleValue = number?.doubleValue {
                    let balanceBtc = numberDoubleValue / 100000000
                    self.delegate?.didReceiveBalance("\(balanceBtc)", scanCounter:self.scanCounter, sender:self)
                }
            })
            task.resume()
    }
    
}