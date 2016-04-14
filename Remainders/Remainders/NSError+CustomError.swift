//
//  NSError+CustomError.swift
//  Remainders
//
//  Created by projas on 4/13/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit

extension NSError {
    
    
    static func errorWithMessage(message: String) -> NSError{
        let error = NSError(domain: "Remainders.Nearsoft", code: -1, userInfo: ["message" : message])
        return error
    }
    
    func getMessage() -> String{
        return String(self.userInfo["message"])
    }

}
