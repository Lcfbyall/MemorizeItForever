//
//  FakeWordInProgressDataAccess.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/1/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation
import BaseDataAccess
@testable import MemorizeItForever

class FakeWordInProgressDataAccess: WordInProgressDataAccess {
    override init(initialContext: ManagedObjectContextProtocol){
        super.init(initialContext: initialContext)
    }
    
    convenience init(){
        self.init(initialContext: InMemoryManagedObjectContext())
    }
}