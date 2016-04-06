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
    
    
    static func deleteUserFromRealm(user: User) -> Void {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(user)
        }
    }
    
    static func saveUserIntoRealmWithResult(result: [String: String]) -> Void {
        let user = User(WithName: result["name"]!, email: result["email"]!, tokenId: result["id"]!)
        let realm = try! Realm()
        
        try! realm.write({
            realm.add(user)
            FBSDKLoginManager().logOut()
        })
    }
    
    static func updateLoginState(user: User, isUserLogged: Bool) -> Void {
        let realm = try! Realm()
        
        try! realm.write({ 
            user.isLogged = isUserLogged
        })
    }

}
