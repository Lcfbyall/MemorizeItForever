//
//  FakeGenericDataAccess.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/23/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation
import CoreData
import BaseDataAccess

@testable import MemorizeItForever

class InMemoryManagedObjectContext: ManagedObjectContextProtocol {

    private var _context: NSManagedObjectContext?
    var managedObjectContext: NSManagedObjectContext{
        guard let context = _context else{
            _context = setUpInMemoryManagedObjectContext()
            return _context!
        }
        return context
    }

}