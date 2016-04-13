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
        
//        let queue = dispatch_queue_create("getEventsForCurrentUser", DISPATCH_QUEUE_SERIAL)
//        dispatch_async(queue) {
            do{
                try UserService.getLoggedUserWithCompletionHandler({ (user) in
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
            }catch{
                onFailure?(error: NSError(domain: "", code: 404, userInfo: nil))
            }
//        }
        
    
    }
    
    
    static func getEventWithDate(date: NSDate, completion: ((event: Event) -> Void)?, onFailure: ((error: NSError) -> Void)?){
        
//        let queue = dispatch_queue_create("getEventWithDate", DISPATCH_QUEUE_SERIAL)
//        dispatch_async(queue) {
            do{
                try UserService.getLoggedUserWithCompletionHandler({ (user) in
                    let event = user.events.filter("date == %@",date).first!
                    completion!(event: event)
                }, onFailure: { (error) in
                    onFailure?(error: error)
                })
            }catch{
                onFailure?(error: NSError(domain: "", code: 404, userInfo: nil))
            }
//        }
        
    }
    
    static func saveEventIntoRealm(event: Event, completion: (() -> Void)?,  onFailure: ((error: NSError) -> Void)?) throws -> Void {
//        let queue = dispatch_queue_create("saveEventIntoRealm", DISPATCH_QUEUE_SERIAL)
//        dispatch_async(queue) {
            do{
                let realm = try Realm()
                
                try realm.write({
                    realm.add(event)
                })
                completion?()
            }catch{
                onFailure?(error: NSError(domain: "", code: 404, userInfo: nil))
            }
//        }
    }
    
    static func saveUserEventIntoRealm(event: Event,completion: (() -> Void)?,  onFailure: ((error: NSError) -> Void)?) throws -> Void{

//        let queue = dispatch_queue_create("saveUserEventIntoRealm", DISPATCH_QUEUE_SERIAL)
//        dispatch_async(queue) {
            do{
                try UserService.getLoggedUserWithCompletionHandler({ (user) in
                    let realm = try! Realm()
                    
                    try! realm.write({
                        user.events.append(event)
                    })
                }, onFailure: { (error) in
                    onFailure?(error: error)
                })
            }catch{
                onFailure?(error: NSError(domain: "", code: 404, userInfo: nil))
            }
//        }

    }
    
    
    static func saveNewEvent(event: Event, completion: (() -> Void)?,  onFailure: ((error: NSError) -> Void)?){
//        let queue = dispatch_queue_create("saveNewEvent", DISPATCH_QUEUE_SERIAL)
//        dispatch_async(queue) {
            do{
                try saveEventIntoRealm(event, completion: nil, onFailure: nil)
                try saveUserEventIntoRealm(event, completion: nil, onFailure: nil)
                try UILocalNotification.setNotificationWithEvent(event)
                completion?()
            }catch{
                onFailure?(error: NSError(domain: "", code: 404, userInfo: nil))
            }
//        }
    }
    
    
    static func updateEvent(eventToUpdate: Event, newEvent: Event, completion: (() -> Void)?,  onFailure: ((error: NSError) -> Void)?){
        
//        let queue = dispatch_queue_create("updateEvent", DISPATCH_QUEUE_SERIAL)
//        dispatch_async(queue) {
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
//        }
    }
    
    static func deleteEvent(event: Event, completion: (() -> Void)?,  onFailure: ((error: NSError) -> Void)?){
        
//        let queue = dispatch_queue_create("deleteEvent", DISPATCH_QUEUE_SERIAL)
//        dispatch_async(queue) {
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
//        }
    }
}
