//
//  BalanceTableViewController.swift
//  Paper Wallet Checker
//
//  Created by Fabian Lachman on 25/04/15.
//  Copyright (c) 2015 Fabian Lachman. All rights reserved.
//

import UIKit

class BalanceTableViewController: UITableViewController {
    
    lazy var results = NSMutableArray()
    
    func addResult(balance: String, source: NSString)
    {
        results.addObject(["balance": balance, "source": source])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("balanceCell", forIndexPath: indexPath) as! BalanceCellTableViewCell
        
        cell.balanceLabel.text = results[indexPath.row]["balance"] as? String
        cell.sourceLabel.text = results[indexPath.row]["source"] as? String

        return cell
    }
    
}
