//
//  EventViewCell.swift
//  Remainders
//
//  Created by projas on 4/7/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit

class EventViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dayLabel.layer.borderWidth = 1
        dayLabel.layer.borderColor = UIColor.blackColor().CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellWithEvent(event: Event) -> Void {
        self.titleLabel.text = event.title
        self.dayLabel.text = NSCalendar.getDayFromDate(event.date)
        self.monthLabel.text = NSCalendar.getMonthNameFromDate(event.date)
    }

}
