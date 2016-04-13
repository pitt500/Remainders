//
//  UserService.swift
//  Remainders
//
//  Created by projas on 4/11/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import RealmSwift

class UserService: NSObject {
    static func getLoggedUserWithCompletionHandler(completion: ((user: User) ->Void)?, onFailure: ((error: NSError) -> Void)?) throws -> Void {
        
//        let queue = dispatch_queue_create("getLoggedUser", DISPATCH_QUEUE_SERIAL)
//        dispatch_async(queue) {
                do{
                    let realm = try Realm()
                    let user = realm.objects(User).filter("isLogged == true").first
                    
                    
                    if let actualUser = user {
                        completion?(user: actualUser)
                    }else{
                        onFailure?(error: NSError(domain: "", code: 0, userInfo: ["message" : "Something went wrong"]))
                    }
                    
                }catch{
                    onFailure?(error: NSError(domain: "", code: 0, userInfo: ["message" : "Something went wrong"]))
                }
            
//        }
        
    }
    
    static func checkIfAnyUserIsLoggedWithCompletion(completion: ((isUserLogged: Bool) -> Void)?, onFailure: ((error: NSError) -> Void)?) -> Void{
        
//        let queue = dispatch_queue_create("checkIfAnyUserIsLogged", DISPATCH_QUEUE_SERIAL)
//        dispatch_async(queue) {
            do{
                let realm = try Realm()
                let user = realm.objects(User).filter("isLogged == true")
                let isAnyLogged = (user.count == 1) ? true : false
                completion?(isUserLogged: isAnyLogged)
            }catch{
                onFailure?(error: NSError(domain: "", code: 0, userInfo: ["message" : "Something went wrong"]))
            }
//        }
        
    }
    
    
    
    
    
    static func getUserWithEmail(email: String, completion: ((user: User?) -> Void)?, onFailure: ((error: NSError) -> Void)?) -> Void{
        
//        let queue = dispatch_queue_create("getUserWithEmail", DISPATCH_QUEUE_SERIAL)
//        dispatch_async(queue) {
            do{
                let realm = try Realm()
                let user: User? = realm.objects(User).filter("email == '\(email)'").first
                completion?(user: user)
            }catch{
                onFailure?(error: NSError(domain: "", code: 0, userInfo: ["message" : "Something went wrong"]))
            }
//        }
    }
    
    
    static func deleteUserFromRealm(user: User, completion: (() -> Void)?, onFailure: ((error: NSError) -> Void)?) -> Void {
//        let queue = dispatch_queue_create("deleteUserFromRealm", DISPATCH_QUEUE_SERIAL)
//        dispatch_async(queue) {
            do{
                let realm = try Realm()
                try realm.write {
                    realm.delete(user)
                }
                completion?()
            
            }catch{
                onFailure?(error: NSError(domain: "", code: 0, userInfo: ["message" : "Something went wrong"]))
            }
//        }
    }
    
    static func saveUserIntoRealm(user: User, completion: (() -> Void)?, onFailure: ((error: NSError) -> Void)?) -> Void {
        
//        let queue = dispatch_queue_create("saveUserIntoRealm", DISPATCH_QUEUE_SERIAL)
//        dispatch_async(queue) {
            do{
                let realm = try Realm()
                
                try realm.write({
                    realm.add(user)
                })
                completion?()
            }catch{
                onFailure?(error: NSError(domain: "", code: 0, userInfo: ["message" : "Something went wrong"]))
            }
//        }
    }
    
    static func saveUserEventIntoRealm(event: Event, completion: (() -> Void)?, onFailure: ((error: NSError) -> Void)?) -> Void{
        
//        let queue = dispatch_queue_create("saveUserEventIntoRealm", DISPATCH_QUEUE_SERIAL)
//        dispatch_async(queue) {
            do{
                try getLoggedUserWithCompletionHandler({ (user) in
                    let realm = try! Realm()
                    
                    try! realm.write({
                        user.events.append(event)
                    })
                    completion?()
                }) { (error) in
                    onFailure?(error: error)
                }
            }catch{
                onFailure?(error: NSError(domain: "", code: 0, userInfo: ["message" : "Something went wrong"]))
            }
//        }
    }
    
    static func updateLoginState(user: User, isUserLogged: Bool, completion: (() -> Void)?, onFailure: ((error: NSError) -> Void)?) -> Void {
        
//        let queue = dispatch_queue_create("updateLoginState", DISPATCH_QUEUE_SERIAL)
//        dispatch_async(queue) {
            do{
                let realm = try Realm()
                
                try realm.write({
                    user.isLogged = isUserLogged
                    realm.add(user, update: true)
                })
            }catch{
                onFailure?(error: NSError(domain: "", code: 0, userInfo: ["message" : "Something went wrong"]))
            }
//        }
    }
    
}
