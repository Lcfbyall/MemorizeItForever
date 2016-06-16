//
//  WordHistoryDataAccess.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/3/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation
import BaseDataAccess

class WordHistoryDataAccess: BaseDataAccess, DataAccessProtocol {
    private var _dataAccess: GenericDataAccess<WordHistoryEntity>? = nil
    var dataAccess : GenericDataAccess<WordHistoryEntity>{
        guard let wordHistoryDataAccess = _dataAccess else{
            _dataAccess = GenericDataAccess<WordHistoryEntity>(initialContext: context)
            return _dataAccess!
        }
        return wordHistoryDataAccess
    }
    
    func saveOrUpdateWordHistoryEntity(wordHistoryModel: WordHistoryModel) throws{
        guard let wordId = wordHistoryModel.word?.wordId else{
            throw EntityCRUDError.FailSaveEntity(getEntityName())
        }
        do{
            var wordHistoryEntity = try fetchWordHistoryEntityByWordIdAndColumnNo(wordHistoryModel)
            if wordHistoryEntity == nil{
                wordHistoryEntity = try dataAccess.createNewInstance()
                wordHistoryEntity?.id = generateId()
                wordHistoryEntity?.columnNo = wordHistoryModel.columnNo
                wordHistoryEntity?.failureCount = 1
                wordHistoryEntity?.word = fetchWordEntity(wordId)
            }
            else{
                wordHistoryEntity!.failureCount = NSNumber(int: wordHistoryEntity!.failureCount!.intValue + 1)
            }
            try dataAccess.saveEntity(wordHistoryEntity!)
        }
        catch EntityCRUDError.FailNewEntity(let entityName){
            throw EntityCRUDError.FailNewEntity(entityName)
        }
        catch let error as NSError{
            throw EntityCRUDError.FailSaveEntity(error.localizedDescription)
        }
    }
    
    func fetchWordHistoryByWordId(wordHistoryModel: WordHistoryModel) throws ->  [WordHistoryModel]{
        guard let wordId = wordHistoryModel.word?.wordId, word = fetchWordEntity(wordId) else{
            throw EntityCRUDError.FailFetchEntity(getEntityName())
        }
        
        let predicateObject = PredicateObject(fieldName: WordHistoryEntity.Fields.Word.rawValue, operatorName: .Equal, value: word)
        
        let sort = SortObject(fieldName: WordHistoryEntity.Fields.ColumnNo.rawValue, direction: .Ascending)
        
        do{
            return try fetchModels(predicateObject, sortProtocol: sort)
        }
        catch{
            throw error
        }
    }
    
    func countWordHistoryByWordId(wordHistoryModel: WordHistoryModel) throws -> Int{
        guard let wordId = wordHistoryModel.word?.wordId, word = fetchWordEntity(wordId) else{
            throw EntityCRUDError.FailFetchEntity(getEntityName())
        }
        
        let predicateObject = PredicateObject(fieldName: WordHistoryEntity.Fields.Word.rawValue, operatorName: .Equal, value: word)
        
        
        do{
            return try dataAccess.fetchEntityCount(predicateObject)
        }
        catch{
            throw error
        }
    }
    
   private func fetchWordHistoryEntityByWordIdAndColumnNo(wordHistoryModel: WordHistoryModel) throws ->  WordHistoryEntity?{
        guard let columnNo = wordHistoryModel.columnNo, wordId = wordHistoryModel.word?.wordId else{
            throw EntityCRUDError.FailFetchEntity(getEntityName())
        }
        
        guard let word = fetchWordEntity(wordId) else{
            throw EntityCRUDError.FailFetchEntity(getEntityName())
        }
        
        let predicateObject1 = PredicateObject(fieldName: WordHistoryEntity.Fields.ColumnNo.rawValue, operatorName: .Equal, value: columnNo)
        let predicateObject2 = PredicateObject(fieldName:  WordHistoryEntity.Fields.Word.rawValue, operatorName: .Equal, value: word)
        var predicateCompoundObject = PredicateCompoundObject(compoundOperator: .And)
        predicateCompoundObject.appendPredicate(predicateObject1)
        predicateCompoundObject.appendPredicate(predicateObject2)
        
        do{
            let items = try fetchEntities(predicateCompoundObject, sortProtocol: nil)
            let count = items.count
            if count > 1{
                throw EntityCRUDError.FailFetchEntity("More than one recoed is retrieved")
            }
            else if count == 1{
                return items[0]
            }
            else{
                return nil
            }
        }
        catch{
            throw error
        }
    }
    
    private func fetchWordEntity(wordId: NSUUID) -> WordEntity?{
        do{
            return try WordDataAccess(initialContext: context).fetchEntity(wordId)
        }
        catch{
            return nil
        }
    }
}