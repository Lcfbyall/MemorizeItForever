//
//  NSDateExtensions.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/1/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation

extension NSDate{
    
    func getDate() -> NSDate?{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        return dateFormatter.dateFromString(dateFormatter.stringFromDate(self))
    }
    
    func addDay(days: Int) -> NSDate? {
        let components = NSDateComponents()
        components.setValue(days, forComponent: NSCalendarUnit.Day);
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: self, options: NSCalendarOptions(rawValue: 0))
    }
    
    func equalToDateWithoutTime(dateToCompare: NSDate) -> Bool {
       if NSCalendar.currentCalendar().compareDate(self, toDate: dateToCompare, toUnitGranularity: .Day) == NSComparisonResult.OrderedSame {
            return true
        }
        return false
    }
}