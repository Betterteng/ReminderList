//
//  ReminderCell.swift
//  ReminderList
//
//  Created by 滕施男 on 15/04/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit

class ReminderCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dueDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
