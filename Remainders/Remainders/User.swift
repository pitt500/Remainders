//
//  User.swift
//  Remainders
//
//  Created by projas on 4/5/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import RealmSwift

class User: Object {
    dynamic var email: String = ""
    dynamic var name: String = ""
    dynamic var isLogged: Bool = true
    
    convenience init(WithName name: String, email: String) {
        self.init()
        self.name = name
        self.email = email
    }
    
    override static func primaryKey() -> String? {
        return "email"
    }
    
    
}
