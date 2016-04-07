//
//  Event.swift
//  Remainders
//
//  Created by projas on 4/6/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import RealmSwift


class Event: Object {
    dynamic var title: String = ""
    dynamic var date: NSDate = NSDate()
    dynamic var note: String = ""
    
    convenience init(WithTitle title: String, date: NSDate, note: String) {
        self.init()
        self.title = title
        self.date = date
        self.note = note
    }
}
