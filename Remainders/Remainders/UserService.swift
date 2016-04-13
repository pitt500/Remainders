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
    
}
