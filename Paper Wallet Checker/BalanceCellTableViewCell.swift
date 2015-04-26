//
//  BalanceCellTableViewCell.swift
//  Paper Wallet Checker
//
//  Created by Fabian Lachman on 25/04/15.
//  Copyright (c) 2015 Fabian Lachman. All rights reserved.
//

import UIKit

class BalanceCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var balanceLabel: UILabel!
    
    @IBOutlet weak var sourceLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
