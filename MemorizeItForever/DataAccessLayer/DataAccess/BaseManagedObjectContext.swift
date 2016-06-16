//
//  BaseManagedObjectContext.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/30/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit
import CoreData
import BaseDataAccess

class BaseManagedObjectContext: ManagedObjectContextProtocol {
    
    private var _context: NSManagedObjectContext?
    var managedObjectContext: NSManagedObjectContext{
        guard let context = _context else{
            _context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
            return _context!
        }
        return context
    }
}
