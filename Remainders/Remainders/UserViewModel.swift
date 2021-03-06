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
    
    static func getLoggedUserWithCompletion(completion: ((user: User)->Void)?, onFailure: ((error: NSError) -> Void)?) -> Void{
        
        try! UserService.getLoggedUserWithCompletionHandler({ (user) in
            
            if let actualUser = user {
                completion?(user: actualUser)
            }else{
                onFailure?(error:  NSError.errorWithMessage("There are not user logged on"))
            }
            
        }) { (error) in
            onFailure?(error: error )
        }
    }
    
    static func getUserWithEmail(email: String, completion: ((user: User?) -> Void)?, onFailure: ((error: NSError) -> Void)?) -> Void{
        UserService.getUserWithEmail(email, completion: { (user) in
            completion?(user: user)
        }) { (error) in
            onFailure?(error: error )
        }
    }
    
    
    static func deleteUserFromRealm(user: User, completion: (() -> Void)?, onFailure: ((error: NSError) -> Void)?) -> Void {
        UserService.deleteUserFromRealm(user, completion: { 
            completion?()
        }) { (error) in
            onFailure?(error: error )
        }
    }
    
    static func saveUserIntoRealm(user: User, completion: (() -> Void)?, onFailure: ((error: NSError) -> Void)?) -> Void {
        UserService.saveUserIntoRealm(user, completion: { 
            completion?()
        }) { (error) in
            onFailure?(error: error )
        }
    }
    
    static func updateLoginState(user: User, isUserLogged: Bool,completion: (() -> Void)?, onFailure: ((error: NSError) -> Void)?) -> Void {
        UserService.updateLoginState(user, isUserLogged:  isUserLogged, completion: {
            completion?()
        }) { (error) in
            onFailure?(error: error )
        }
    }
    
    static func getUserDataFromFacebook() -> Void {
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "email, name"]).startWithCompletionHandler { (connection, result, error) in
            if error == nil{
                let dictionary = result as! [String : String]
                
                UserViewModel.getUserWithEmail(dictionary["email"]!, completion: { (user) in
                    if user != nil{
                        UserViewModel.updateLoginState(user!, isUserLogged: true, completion: nil, onFailure: { (error) in
                            print(error.getMessage())
                        })
                    }else{
                        let newUser = User(WithName: dictionary["name"]!, email: dictionary["email"]!, tokenId: dictionary["id"]!)
                        UserViewModel.saveUserIntoRealm(newUser,  completion: nil, onFailure: { (error) in
                            print(error.getMessage())
                        })
                    }
                    
                    NavigationManager.goMain()
                    }, onFailure: { (error) in
                        print(error.getMessage())
                })
                
            }else{
                print("Error getting facebook data...")
            }
        }
    }

}
