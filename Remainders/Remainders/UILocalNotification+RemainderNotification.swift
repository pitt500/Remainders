//
//  UILocalNotification+RemainderNotification.swift
//  Remainders
//
//  Created by projas on 4/11/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit

extension UILocalNotification {
    
    static func setNotificationWithEvent(event: Event) -> Void{
        let notification = UILocalNotification()
        notification.alertTitle = "Remainder"
        notification.alertBody = event.title
        notification.fireDate = event.date
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
}