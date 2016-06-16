//
//  FakeSetDataAccess.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/23/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation
import BaseDataAccess
@testable import MemorizeItForever

class FakeSetDataAccess: SetDataAccess {
    
    override init(initialContext: ManagedObjectContextProtocol){
        super.init(initialContext: initialContext)
    }
    
    convenience init(){
        self.init(initialContext: InMemoryManagedObjectContext())
    }
}