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
    static func getLoggedUserWithCompletionHandler(completion: (user: User) ->Void, onFailure: (error: NSError) -> Void) -> Void {
        let realm = try! Realm()
        let user = realm.objects(User).filter("isLogged == true").first
        
        
        if let actualUser = user {
            completion(user: actualUser)
        }else{
            onFailure(error: NSError(domain: "", code: 0, userInfo: ["message" : "Something went wrong"]))
        }
        
    }
    
    static func checkIfAnyUserIsLoggedWithCompletion(completion: ((isUserLogged: Bool) -> Void)?, onFailure: ((error: NSError) -> Void)?) -> Void{
        
        do{
            let realm = try Realm()
            let user = realm.objects(User).filter("isLogged == true")
            let isAnyLogged = (user.count == 1) ? true : false
            completion?(isUserLogged: isAnyLogged)
        }catch{
            onFailure?(error: NSError(domain: "", code: 0, userInfo: ["message" : "Something went wrong"]))
        }
        
    }
    
    
    
    //    static func getLoggedUser(completion: (user: User)->Void, onFailure: (error: NSError) -> Void) -> Void{
    //
    //        UserService.getLoggedUserWithCompletionHandler({ (user) in
    //            completion(user: user )
    //        }) { (error) in
    //            onFailure(error: error )
    //        }
    //    }
    
    static func getUserWithEmail(email: String) -> User?{
        let realm = try! Realm()
        let user: User? = realm.objects(User).filter("email == '\(email)'").first
        return user
    }
    
    
    static func deleteUserFromRealm(user: User) -> Void {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(user)
        }
    }
    
    static func saveUserIntoRealm(user: User) -> Void {
        let realm = try! Realm()
        
        try! realm.write({
            realm.add(user)
        })
    }
    
    static func saveUserEventIntoRealm(event: Event, loggedUser: User) -> Void{
        let realm = try! Realm()
        
        try! realm.write({
            loggedUser.events.append(event)
        })
    }
    
    //    static func saveUserEventIntoRealm(event: Event) -> Void{
    //
    //
    //        UserViewModel.getLoggedUser({ (user) in
    //            let realm = try! Realm()
    //
    //            try! realm.write({
    //                user.events.append(event)
    //            })
    //        }) { (error) in
    //            print(error.userInfo["message"])
    //        }
    //
    //
    //    }
    
    static func updateLoginState(user: User, isUserLogged: Bool) -> Void {
        let realm = try! Realm()
        
        try! realm.write({
            user.isLogged = isUserLogged
            realm.add(user, update: true)
        })
    }
}
