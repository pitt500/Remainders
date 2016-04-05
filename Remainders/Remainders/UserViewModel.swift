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

}
