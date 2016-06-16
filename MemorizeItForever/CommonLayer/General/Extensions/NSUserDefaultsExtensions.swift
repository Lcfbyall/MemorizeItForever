//
//  NSUserDefaultsExtensions.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 3/27/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit

extension NSUserDefaults{
    
    func colorForKey(key: String) -> UIColor?{
        var color: UIColor?
        if let colorData = dataForKey(key){
            color = NSKeyedUnarchiver.unarchiveObjectWithData(colorData) as? UIColor
        }
        return color
    }
    
    func setColor(color: UIColor?, forKey key: String){
        var colorData: NSData?
        if let color = color{
            colorData = NSKeyedArchiver.archivedDataWithRootObject(color)
        }
        setObject(colorData, forKey: key)
    }
}
