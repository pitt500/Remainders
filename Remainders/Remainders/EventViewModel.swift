//
//  EventViewModel.swift
//  Remainders
//
//  Created by projas on 4/7/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import RealmSwift
import Timepiece

class EventViewModel: NSObject {

    static func saveEventIntoRealm(event: Event) -> Void {
        let realm = try! Realm()
        
        try! realm.write({
            realm.add(event)
        })
    }
    
    static func getEventsForUser(user: User, dateComparison: DateComparison) -> [Event] {
        let today = NSDate()
        let eventArray = Array(user.events)
        
        if dateComparison == .BeforeToday {
            return eventArray.filter({ $0.date < today }).sort({ $0.date > $1.date })
        } else if dateComparison == .AfterToday{
            return eventArray.filter({ $0.date > today }).sort({ $0.date > $1.date })
        }
        
        //dateComparison == .Today
        return eventArray.filter({ $0.date == today }).sort({ $0.date > $1.date })
    }
    
    static func deleteEvent(event: Event){
        let realm = try! Realm()
        
        try! realm.write({
            realm.delete(event)
        })
    }
}
