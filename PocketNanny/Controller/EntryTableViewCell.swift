//
//  EntryTableViewCell.swift
//  PocketNanny
//
//  Created by Hao Pan on 2015-05-24.
//  Copyright (c) 2015 Anthony Pan. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    @IBOutlet weak var timeStamp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
