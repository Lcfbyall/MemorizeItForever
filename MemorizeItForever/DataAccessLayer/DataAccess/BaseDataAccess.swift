//
//  BaseDataAccess.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/30/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import BaseDataAccess

class BaseDataAccess {
    private let _context: ManagedObjectContextProtocol
    var context : ManagedObjectContextProtocol{
        return _context
    }
    
    init(initialContext: ManagedObjectContextProtocol){
        _context = initialContext
    }
    
    convenience init(){
        self.init(initialContext: BaseManagedObjectContext())
    }
}