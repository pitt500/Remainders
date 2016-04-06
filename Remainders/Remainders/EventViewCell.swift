//
//  EventViewCell.swift
//  Remainders
//
//  Created by projas on 4/6/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit

class EventViewCell: UITableViewCell {

    
    @IBOutlet weak var calendarView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.calendarView.layer.borderWidth = 1
        self.calendarView.layer.borderColor = UIColor.blackColor().CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
