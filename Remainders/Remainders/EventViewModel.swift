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
    
    static func deleteEvent(event: Event, completion: (() -> Void)?,  onFailure: ((error: NSError) -> Void)?){
        EventService.deleteEvent(event, completion: nil) { (error) in
            onFailure?(error: error)
        }
    }
    
    static func getEventWithDate(date: NSDate, completion: ((event: Event) -> Void)?, onFailure: ((error: NSError) -> Void)?){
        EventService.getEventWithDate(date, completion: { (event) in
            completion?(event: event)
        }) { (error) in
            onFailure?(error: error)
        }
    }
    
    static func getEventsForCurrentUser(dateComparison: DateComparison, completion: ((events: [Event]) -> Void)?, onFailure: ((error: NSError) -> Void)?) -> Void{
        EventService.getEventsForCurrentUser(dateComparison, completion: { (events) in
            completion!(events: events)
        }) { (error) in
            onFailure!(error: error)
        }
    }
    
    static func saveNewEvent(event: Event, completion: (() -> Void)?,  onFailure: ((error: NSError) -> Void)?){
        
        EventService.saveNewEvent(event, completion: { 
            completion?()
        }) { (error) in
            onFailure?(error: error)
        }
        
    }
    
    static func updateEvent(eventToUpdate: Event, newEvent: Event, completion: (() -> Void)?,  onFailure: ((error: NSError) -> Void)?){
        
        EventService.updateEvent(eventToUpdate, newEvent: newEvent, completion: nil) { (error) in
            onFailure?(error: error)
        }
    }
}
