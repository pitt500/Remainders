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
    
    static func getEventsForCurrentUser(completion: ((events: [Event]) -> Void)?, onFailure: ((error: NSError) -> Void)?) -> Void{
        
        do{
            try UserService.getLoggedUserWithCompletionHandler({ (user) in
                completion?(events: Array(user!.events))
            }, onFailure: { (error) in
                onFailure?(error: error)
            })
        }catch{
            onFailure?(error: NSError.errorWithMessage("Error getting logged user"))
        }
        
    }
    
    
    static func getEventWithDate(date: NSDate, completion: ((event: Event) -> Void)?, onFailure: ((error: NSError) -> Void)?){
    
        do{
            try UserService.getLoggedUserWithCompletionHandler({ (user) in
                let event = user!.events.filter("date == %@",date).first!
                completion?(event: event)
            }, onFailure: { (error) in
                onFailure?(error: error)
            })
        }catch{
            onFailure?(error: NSError.errorWithMessage("Error getting event with date"))
        }
    }
    
    static func saveEventIntoRealm(event: Event, completion: (() -> Void)?,  onFailure: ((error: NSError) -> Void)?) throws -> Void {
        do{
            let realm = try Realm()
            
            try realm.write({
                realm.add(event)
            })
            completion?()
        }catch{
            onFailure?(error: NSError.errorWithMessage("Error saving event into Realm"))
        }
    }
    
    static func addEventToLoggedUser(event: Event,completion: (() -> Void)?,  onFailure: ((error: NSError) -> Void)?) throws -> Void{

        do{
            try UserService.getLoggedUserWithCompletionHandler({ (user) in
                let realm = try! Realm()
                
                try! realm.write({
                    user!.events.append(event)
                })
            }, onFailure: { (error) in
                onFailure?(error: error)
            })
            completion?()
        }catch{
            onFailure?(error: NSError.errorWithMessage("Error saving User's event into Realm"))
        }

    }
    
    
    static func saveNewEvent(event: Event, completion: (() -> Void)?,  onFailure: ((error: NSError) -> Void)?){
        do{
            try saveEventIntoRealm(event, completion: nil, onFailure: { (error) in
                onFailure?(error: error)
            })
            try addEventToLoggedUser(event, completion: nil,  onFailure: { (error) in
                onFailure?(error: error)
            })
            completion?()
        }catch{
            onFailure?(error: NSError.errorWithMessage("Error processing new event"))
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
            onFailure?(error: NSError.errorWithMessage("Error updating event"))
        }
    }
    
    static func deleteEvent(event: Event, completion: (() -> Void)?,  onFailure: ((error: NSError) -> Void)?){
        
        do{
            completion?()
            let realm = try Realm()
            try realm.write({
                realm.delete(event)
                
            })
        }catch{
            onFailure?(error: NSError.errorWithMessage("Error deleting event"))
        }
    }
}
