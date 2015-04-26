//
//  LuxstackBalanceFetcher.swift
//  Paper Wallet Checker
//
//  Created by Fabian Lachman on 25/04/15.
//  Copyright (c) 2015 Fabian Lachman. All rights reserved.
//

import Foundation
import SwiftyJSON

class LuxstackBalanceFetcher : BalanceFetcher
{
    
    override func fetch(address: String) {
        let appId = valueForAPIKey(keyname:  "luxstack.com_app_id")
        let appSecret = valueForAPIKey(keyname:  "luxstack.com_app_secret")
        
        var request = NSMutableURLRequest(URL: NSURL(string: "https://api.luxstack.com/api/v1/explorer/address")!)
        var params = "address=\(address)&appId=\(appId)&appSecret=\(appSecret)";
        
        request.HTTPMethod = "POST"
        request.HTTPBody = params.dataUsingEncoding(NSUTF8StringEncoding)
        
        let session = NSURLSession.sharedSession()
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            let json = JSON(data: data)
            if let balanceBtc = json["balance"].double {
//          if let balanceBtc = json["unconfirmedBalance"].double {
                
                self.delegate?.didReceiveBalance("\(balanceBtc)", scanCounter:self.scanCounter, sender: self)
            }
        });

        task.resume()
    }
    
    
}