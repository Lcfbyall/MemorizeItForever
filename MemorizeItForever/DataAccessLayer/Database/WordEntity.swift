//
//  WordEntity.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/12/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation
import CoreData
import BaseDataAccess


class WordEntity: NSManagedObject, EntityProtocol {

// Insert code here to add functionality to your managed object subclass
    
    static var entityName: String{
        return Entities.WordEntity.rawValue
    }
    
    static var idField: String{
        return Fields.Id.rawValue
    }
    
    func toModel() throws -> ModelProtocol {
        guard let id = self.id, setId = self.set?.id else{
            throw ModelError.FailCreateModel(Models.WordModel.rawValue)
        }
        
        var word = WordModel()
        word.status = self.status?.longValue
        word.order = self.order?.unsignedIntegerValue
        word.wordId = NSUUID(UUIDString: id)
        word.setId = NSUUID(UUIDString: setId)
        word.meaning = self.meaning
        word.phrase = self.phrase
        return word
    }
    
    enum Fields: String {
        case Id = "id"
        case Meaning = "meaning"
        case Order = "order"
        case Phrase = "phrase"
        case Status = "status"
        case Set = "set"
    }
}
