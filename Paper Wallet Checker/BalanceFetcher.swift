//
//  BalanceFetcher.swift
//  Paper Wallet Checker
//
//  Created by Fabian Lachman on 25/04/15.
//  Copyright (c) 2015 Fabian Lachman. All rights reserved.
//

import Foundation

class BalanceFetcher {
    
    var delegate : BalanceFetcherDelegate?
    var sourceTitle = "Unkown";
    var scanCounter = 0
    
    func fetch(address : String) {
        
    }

}

protocol BalanceFetcherDelegate {
    func didReceiveBalance(balance : String, scanCounter : Int, sender : BalanceFetcher)
}