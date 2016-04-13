//
//  EventService.swift
//  Remainders
//
//  Created by projas on 4/11/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import RealmSwift

class EventService: NSObject {
    
    static func getEventsForCurrentUser(dateComparison: DateComparison, completion: ((events: [Event]) -> Void)?, onFailure: ((error: NSError) -> Void)?) -> Void{
        
        UserService.getLoggedUserWithCompletionHandler({ (user) in
            let today = NSDate()
            let eventArray = Array(user.events)
            let filteredEvents: [Event]
            
            if dateComparison == .PastEvents {
                filteredEvents = eventArray.filter({ $0.date < today }).sort({ $0.date > $1.date })
            } else if dateComparison == .UpcomingEvents{
                filteredEvents =  eventArray.filter({ $0.date > today }).sort({ $0.date > $1.date })
            }else{
                //dateComparison == .Today
                filteredEvents =  eventArray.filter({ $0.date == today }).sort({ $0.date > $1.date })
            }
            
            completion?(events: filteredEvents)
        }, onFailure: { (error) in
            onFailure?(error: error)
        })
        
    }
    
    
    static func getEventWithDate(date: NSDate, completion: ((event: Event) -> Void)?, onFailure: ((error: NSError) -> Void)?){
        UserService.getLoggedUserWithCompletionHandler({ (user) in
            let event = user.events.filter("date == %@",date).first!
            completion!(event: event)
        }, onFailure: { (error) in
            onFailure?(error: error)
        })
        
    }
    
    static func saveEventIntoRealm(event: Event) throws -> Void {
        let realm = try! Realm()
        
        try! realm.write({
            realm.add(event)
        })
    }
    
    static func saveUserEventIntoRealm(event: Event,completion: (() -> Void)?,  onFailure: ((error: NSError) -> Void)?) throws -> Void{

        UserService.getLoggedUserWithCompletionHandler({ (user) in
            let realm = try! Realm()
            
            try! realm.write({
                user.events.append(event)
            })
        }, onFailure: { (error) in
            onFailure?(error: error)
        })
        

    }
    
    
    static func saveNewEvent(event: Event, completion: (() -> Void)?,  onFailure: ((error: NSError) -> Void)?){
        do{
//            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
//            dispatch_async(dispatch_get_global_queue(priority, 0)) {
//                
//            }
            
            try saveEventIntoRealm(event)
            try saveUserEventIntoRealm(event, completion: nil, onFailure: nil)
            try UILocalNotification.setNotificationWithEvent(event)
            completion?()
        }catch{
            onFailure?(error: NSError(domain: "", code: 404, userInfo: nil))
        }
    }
    
    
    static func updateEvent(eventToUpdate: Event, newEvent: Event, completion: (() -> Void)?,  onFailure: ((error: NSError) -> Void)?){
        
        do{
            let realm = try Realm()
            
            try realm.write({
                eventToUpdate.title = newEvent.title
                eventToUpdate.date = newEvent.date
                eventToUpdate.note = newEvent.note
            })
            
            completion?()
        }catch{
            onFailure?(error: NSError(domain: "", code: 404, userInfo: nil))
        }
    }
    
    static func deleteEvent(event: Event, completion: (() -> Void)?,  onFailure: ((error: NSError) -> Void)?){        
        do{
            try UILocalNotification.cancelNotificationForEvent(event)
            
            let realm = try Realm()
            try realm.write({
                realm.delete(event)
                
            })
            
            completion?()
        }catch{
            onFailure?(error: NSError(domain: "", code: 404, userInfo: nil))
        }
    }
}
