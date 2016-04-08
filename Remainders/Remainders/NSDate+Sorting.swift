//
//  NSDate+Sorting.swift
//  Remainders
//
//  Created by projas on 4/8/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit

public func <(a: NSDate, b: NSDate) -> Bool {
    return a.compare(b) == NSComparisonResult.OrderedAscending
}

public func ==(a: NSDate, b: NSDate) -> Bool {
    return a.compare(b) == NSComparisonResult.OrderedSame
}

public func >(a: NSDate, b: NSDate) -> Bool {
    return a.compare(b) == NSComparisonResult.OrderedDescending
}

extension NSDate: Comparable { }
