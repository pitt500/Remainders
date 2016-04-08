//
//  NSCalendar+DateComponents.swift
//  Remainders
//
//  Created by projas on 4/7/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit

extension NSCalendar {

    static func getMonthNameFromDate(date: NSDate) -> String{
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        let months = dateFormatter.shortMonthSymbols
        return months[components.month-1]
    }
    
    
    static func getDayFromDate(date: NSDate) -> String{
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        return String(components.day)
    }

}

public enum DateComparison : Int {
    
    case BeforeToday
    case Today
    case AfterToday
}