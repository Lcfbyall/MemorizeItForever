//
//  WordInProgressDataAccess.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/1/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//
import Foundation
import BaseDataAccess

class WordInProgressDataAccess: BaseDataAccess, DataAccessProtocol {
    private var _dataAccess: GenericDataAccess<WordInProgressEntity>? = nil
    var dataAccess : GenericDataAccess<WordInProgressEntity>{
        guard let wordInProgressDataAccess = _dataAccess else{
            _dataAccess = GenericDataAccess<WordInProgressEntity>(initialContext: context)
            return _dataAccess!
        }
        return wordInProgressDataAccess
    }
    
    func fetchWordInProgress() throws -> [WordInProgressModel]{
        do{
            return try fetchModels(nil, sortProtocol: nil)
        }
        catch let error as NSError{
            throw DataAccessError.FailFetchData(error.localizedDescription)
        }
    }
    
    func saveWordInProgressEntity(wordInProgressModel: WordInProgressModel) throws{
        guard let wordId = wordInProgressModel.word?.wordId else{
            throw EntityCRUDError.FailSaveEntity(getEntityName())
        }
        do{
            let wordInProgressEntity = try dataAccess.createNewInstance()
            wordInProgressEntity.id = generateId()
            wordInProgressEntity.column = wordInProgressModel.column
            wordInProgressEntity.date = wordInProgressModel.date?.getDate()
            wordInProgressEntity.word = fetchWordEntity(wordId)
            try dataAccess.saveEntity(wordInProgressEntity)
        }
        catch EntityCRUDError.FailNewEntity(let entityName){
            throw EntityCRUDError.FailNewEntity(entityName)
        }
        catch let error as NSError{
            throw EntityCRUDError.FailSaveEntity(error.localizedDescription)
        }
    }
    
    func editWordInProgressEntity(wordInProgressModel: WordInProgressModel) throws{
        do{
            guard let id = wordInProgressModel.wordInProgressId else{
                throw EntityCRUDError.FailSaveEntity(getEntityName())
            }
            
            if let wordInProgressEntity = try fetchEntity(id){
                wordInProgressEntity.column = wordInProgressModel.column
                wordInProgressEntity.date = wordInProgressModel.date?.getDate()
                try dataAccess.saveEntity(wordInProgressEntity)
            }
            else{
                throw DataAccessError.FailFetchData("There is no WordInProgressEntity entity with id: \(id)")
            }
        }
        catch let error as NSError{
            throw DataAccessError.FailEditData(error.localizedDescription)
        }
    }
    
    func deleteWordInProgressEntity(wordInProgressModel: WordInProgressModel) throws{
        do{
            guard let id = wordInProgressModel.wordInProgressId else{
                throw EntityCRUDError.FailDeleteEntity(getEntityName())
            }
            
            if let wordInProgressEntity = try fetchEntity(id){
                try dataAccess.deleteEntity(wordInProgressEntity)
            }
            else{
                throw DataAccessError.FailFetchData("There is no WordInProgressEntity entity with id: \(id)")
            }
        }
        catch let error as NSError{
            throw DataAccessError.FailDeleteData(error.localizedDescription)
        }
    }

    func fetchWordInProgressByWordId(wordInProgressModel: WordInProgressModel) throws -> WordInProgressModel?{
        guard let wordId = wordInProgressModel.word?.wordId, word = fetchWordEntity(wordId) else{
            throw EntityCRUDError.FailFetchEntity(getEntityName())
        }
        
        let predicateObject = PredicateObject(fieldName: WordInProgressEntity.Fields.Word.rawValue, operatorName: .Equal, value: word)
        
        do{
            let words: [WordInProgressModel] = try fetchModels(predicateObject, sortProtocol: nil)
            if words.count == 1{
               return words[0]
            }
            else{
                return nil
            }
        }
        catch{
            throw error
        }
    }
    
    func fetchWordInProgressByDateAndColumn(wordInProgressModel: WordInProgressModel) throws -> [WordInProgressModel]{
        guard let date = wordInProgressModel.date?.getDate(), column = wordInProgressModel.column else{
            throw EntityCRUDError.FailFetchEntity(getEntityName())
        }
        
        let predicateObject1 = PredicateObject(fieldName: WordInProgressEntity.Fields.Column.rawValue, operatorName: .Equal, value: column)
        let predicateObject2 = PredicateObject(fieldName: WordInProgressEntity.Fields.Date.rawValue, operatorName: .Equal, value: date)
        
        var predicateCompound = PredicateCompoundObject(compoundOperator: CompoundOperatorEnum.And)
        predicateCompound.appendPredicate(predicateObject1)
        predicateCompound.appendPredicate(predicateObject2)
        
        do{
            let wordInProgress: [WordInProgressModel] = try fetchModels(predicateCompound, sortProtocol: nil)
            return wordInProgress
        }
        catch{
            throw error
        }
    }
    
    func fetchWordInProgressByDateAndOlder(wordInProgressModel: WordInProgressModel) throws -> [WordInProgressModel]{
        guard let date = wordInProgressModel.date?.getDate() else{
            throw EntityCRUDError.FailFetchEntity(getEntityName())
        }
        
        let predicateObject = PredicateObject(fieldName: WordInProgressEntity.Fields.Date.rawValue, operatorName: .LessEqualThan, value: date)
        
        do{
            let wordInProgress: [WordInProgressModel] = try fetchModels(predicateObject, sortProtocol: nil)
            return wordInProgress
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
