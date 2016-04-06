//
//  UserViewModel.swift
//  Remainders
//
//  Created by projas on 4/5/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import RealmSwift
import FBSDKLoginKit



class UserViewModel: NSObject {
    
    static func setRealmSchemaWithVersion(version: UInt64){
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: version,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < version) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
    
    static func isAnyUserLogged() -> Bool{
        
        let realm = try! Realm()
        
        let user = realm.objects(User).filter("isLogged == true")
        if user.count >= 1{
            return true
        }
        
        return false
    }
    
    static func getLoggedUser() -> User{
        let realm = try! Realm()
        let user = realm.objects(User).filter("isLogged == true").first
        return user!
    }
    
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
    
    static func updateLoginState(user: User, isUserLogged: Bool) -> Void {
        let realm = try! Realm()
        
        try! realm.write({ 
            user.isLogged = isUserLogged
            realm.add(user, update: true)
        })
    }

}
