//
//  FakeWordHistoryDataAccess.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/3/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation
import BaseDataAccess

@testable import MemorizeItForever

class FakeWordHistoryDataAccess: WordHistoryDataAccess {
    override init(initialContext: ManagedObjectContextProtocol){
        super.init(initialContext: initialContext)
    }
    
    convenience init(){
        self.init(initialContext: InMemoryManagedObjectContext())
    }
}
