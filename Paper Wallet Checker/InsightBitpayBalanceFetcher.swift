//
//  InsightBitpayBalanceFetcher.swift
//  Paper Wallet Checker
//
//  Created by Fabian Lachman on 25/04/15.
//  Copyright (c) 2015 Fabian Lachman. All rights reserved.
//

import Foundation
import SwiftyJSON

class InsightBitpayBalanceFetcher : BalanceFetcher
{
    
    override func fetch(address: String) {
        
        let urlPath = "https://insight.bitpay.com/api/addr/\(address)"
        let url = NSURL(string: urlPath)
        if (url == nil) { return } 
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {
            data, response, error in
            
            let json = JSON(data: data)
            let balance = json["balance"].stringValue
            
            self.delegate?.didReceiveBalance("\((balance as NSString).doubleValue)", scanCounter:self.scanCounter, sender: self)
        })
        
        task.resume()
    }
    
    
}