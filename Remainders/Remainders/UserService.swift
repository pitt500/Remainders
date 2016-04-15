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
    static func getLoggedUserWithCompletionHandler(completion: ((user: User?) ->Void)?, onFailure: ((error: NSError) -> Void)?) throws -> Void {
        do{
            let realm = try Realm()
            let user = realm.objects(User).filter("isLogged == true").first
            completion?(user: user)
            
        }catch{
            onFailure?(error:  NSError.errorWithMessage("Error accessing to Realm"))
        }
        
    }
    
    
    static func getUserWithEmail(email: String, completion: ((user: User?) -> Void)?, onFailure: ((error: NSError) -> Void)?) -> Void{
        
        do{
            let realm = try Realm()
            let user: User? = realm.objects(User).filter("email == '\(email)'").first
            completion?(user: user)
        }catch{
            onFailure?(error:  NSError.errorWithMessage("Error getting user with email: \(email)"))
        }
    }
    
    
    static func deleteUserFromRealm(user: User, completion: (() -> Void)?, onFailure: ((error: NSError) -> Void)?) -> Void {
        do{
            let realm = try Realm()
            try realm.write {
                realm.delete(user)
            }
            completion?()
        
        }catch{
            onFailure?(error:  NSError.errorWithMessage("Error deleting user from Realm"))
        }
    }
    
    static func saveUserIntoRealm(user: User, completion: (() -> Void)?, onFailure: ((error: NSError) -> Void)?) -> Void {
        
        do{
            let realm = try Realm()
            
            try realm.write({
                realm.add(user)
            })
            completion?()
        }catch{
            onFailure?(error:  NSError.errorWithMessage("Error saving user into Realm"))
        }
    }

    
    static func updateLoginState(user: User, isUserLogged: Bool, completion: (() -> Void)?, onFailure: ((error: NSError) -> Void)?) -> Void {
        
        do{
            let realm = try Realm()
            
            try realm.write({
                user.isLogged = isUserLogged
                realm.add(user, update: true)
            })
            completion?()
        }catch{
            onFailure?(error: NSError.errorWithMessage("Error updating login state"))
        }
    }
    
}
