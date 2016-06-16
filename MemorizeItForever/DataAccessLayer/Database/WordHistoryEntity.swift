//
//  WordHistoryEntity.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/17/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation
import CoreData
import BaseDataAccess


class WordHistoryEntity: NSManagedObject, EntityProtocol {
    
    // Insert code here to add functionality to your managed object subclass
    static var entityName: String{
        return Entities.WordHistoryEntity.rawValue
    }
    static var idField: String{
      return Fields.Id.rawValue
    }
    
    func toModel() throws -> ModelProtocol {
        do{
            var wordHistoryModel = WordHistoryModel()
            wordHistoryModel.word = try self.word?.toModel() as? WordModel
            wordHistoryModel.columnNo = self.columnNo?.integerValue
            wordHistoryModel.failureCount = self.failureCount?.integerValue
            if let wordHistoryId = self.id{
                wordHistoryModel.wordHistoryId = NSUUID( UUIDString: wordHistoryId)
            }
            return wordHistoryModel
        }
        catch{
            throw ModelError.FailCreateModel(Models.WordHistoryModel.rawValue)
        }
    }
    
    enum Fields: String {
        case Id = "id"
        case ColumnNo = "columnNo"
        case FailureCount = "failureCount"
        case Word = "word"
    }
}
