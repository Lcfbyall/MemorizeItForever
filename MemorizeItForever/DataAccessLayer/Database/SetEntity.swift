//
//  SetEntity.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/12/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation
import CoreData
import BaseDataAccess

class SetEntity: NSManagedObject, EntityProtocol {

// Insert code here to add functionality to your managed object subclass

    static var entityName: String{
        return Entities.SetEntity.rawValue
    }
    
    static var idField: String{
        return Fields.Id.rawValue
    }
    
    func toModel() throws -> ModelProtocol {
        guard let id = self.id else{
            throw ModelError.FailCreateModel(Models.SetModel.rawValue)
        }
        var setModel = SetModel()
        setModel.setId = NSUUID(UUIDString: id)
        setModel.name = self.name
        return setModel
    }
    
    enum Fields: String {
        case Id = "id"
        case Name = "name"
    }
}
