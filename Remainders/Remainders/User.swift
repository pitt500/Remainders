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
}
