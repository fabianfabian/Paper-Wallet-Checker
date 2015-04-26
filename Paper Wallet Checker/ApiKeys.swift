//
//  ApiKeys.swift
//  Paper Wallet Checker
//
//  Created by Fabian Lachman on 26/04/15.
//  Copyright (c) 2015 Fabian Lachman. All rights reserved.
//

import Foundation

func valueForAPIKey(#keyname:String) -> String {
    let filePath = NSBundle.mainBundle().pathForResource("ApiKeys", ofType:"plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    
    let value:String = plist?.objectForKey(keyname) as! String
    return value
}