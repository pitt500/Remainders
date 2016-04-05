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
    var tokenId: String = ""
    var email: String = ""
    var name: String = ""
    var isLogged: Bool = true
    
    init(WithName name: String, email: String, tokenId: String) {
        super.init()
        self.name = name
        self.email = email
        self.tokenId = tokenId
    }
    
    required init() {
        super.init()
    }
    

    
    
}
