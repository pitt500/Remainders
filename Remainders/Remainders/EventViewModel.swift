//
//  EventViewModel.swift
//  Remainders
//
//  Created by projas on 4/7/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import RealmSwift

class EventViewModel: NSObject {

    static func saveEventIntoRealm(event: Event) -> Void {
        let realm = try! Realm()
        
        try! realm.write({
            realm.add(event)
        })
    }
    
    static func getEventsForUser(user: User) -> [Event] {
        return Array(user.events)
    }
}
