//
//  WordInProgressEntity.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/16/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation
import CoreData
import BaseDataAccess


class WordInProgressEntity: NSManagedObject, EntityProtocol {
    
    // Insert code here to add functionality to your managed object subclass
    
    static var entityName: String{
        return Entities.WordInProgressEntity.rawValue
    }
    static var idField: String{
        return Fields.Id.rawValue
    }
    
    func toModel() throws -> ModelProtocol {
        do{
            var wordInProgressModel = WordInProgressModel()
            wordInProgressModel.word = try self.word?.toModel() as? WordModel
            wordInProgressModel.column = self.column?.integerValue
            wordInProgressModel.date = self.date
            if let wordInProgressId = self.id{
                wordInProgressModel.wordInProgressId = NSUUID(UUIDString: wordInProgressId)
            }
            return wordInProgressModel
        }
        catch{
            throw ModelError.FailCreateModel(Models.WordInProgressModel.rawValue)
        }
    }
    
    enum Fields: String {
        case Id = "id"
        case Column = "column"
        case Date = "date"
        case Word = "word"
    }
}
