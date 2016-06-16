//
//  WordDataAccess.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/30/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation
import BaseDataAccess

class WordDataAccess: BaseDataAccess, DataAccessProtocol {
    
    private var _dataAccess: GenericDataAccess<WordEntity>? = nil
    var dataAccess : GenericDataAccess<WordEntity>{
        guard let wordDataAccess = _dataAccess else{
            _dataAccess = GenericDataAccess<WordEntity>(initialContext: context)
            return _dataAccess!
        }
        return wordDataAccess
    }
    
    func saveWordEntity(wordModel: WordModel) throws{
        guard let setId = wordModel.setId else{
            throw EntityCRUDError.FailSaveEntity(getEntityName())
        }
        do{
            let wordEntity = try dataAccess.createNewInstance()
            wordEntity.id = generateId()
            wordEntity.meaning = wordModel.meaning
            wordEntity.order = try setOrder()
            wordEntity.phrase = wordModel.phrase
            wordEntity.set = fetchSetEntity(setId)
            try dataAccess.saveEntity(wordEntity)
        }
        catch EntityCRUDError.FailNewEntity(let entityName){
            throw EntityCRUDError.FailNewEntity(entityName)
        }
        catch let error as NSError{
            throw EntityCRUDError.FailSaveEntity(error.localizedDescription)
        }
    }
    
    func fetchWords(fetchLimit fetchLimit: Int? = nil) throws -> [WordModel] {
        do{
            let sort = SortObject(fieldName: WordEntity.Fields.Order.rawValue,direction: SortDirectionEnum.Ascending )
            return try fetchModels(nil, sortProtocol: sort, fetchLimit: fetchLimit)
        }
        catch let error as NSError{
            throw  DataAccessError.FailFetchData(error.localizedDescription)
        }
    }
    
    func fetchWordsNotStartedStatus(fetchLimit fetchLimit: Int) throws -> [WordModel] {
        do{
            let sort = SortObject(fieldName: WordEntity.Fields.Order.rawValue,direction: SortDirectionEnum.Ascending )
            let predicaet = PredicateObject(fieldName: WordEntity.Fields.Status.rawValue, operatorName: OperatorEnum.Equal, value: WordStatus.NotStarted.rawValue)
            return try fetchModels(predicaet, sortProtocol: sort, fetchLimit: fetchLimit)
        }
        catch let error as NSError{
            throw  DataAccessError.FailFetchData(error.localizedDescription)
        }
    }
    
    func fetchLastWord(wordStatus: WordStatus) throws -> WordModel? {
        do{
            let sort = SortObject(fieldName: WordEntity.Fields.Order.rawValue, direction: SortDirectionEnum.Descending)
            let predicaet = PredicateObject(fieldName: WordEntity.Fields.Status.rawValue, operatorName: OperatorEnum.Equal, value: wordStatus.rawValue)
            let words: [WordModel] = try fetchModels(predicaet, sortProtocol: sort, fetchLimit: 1)
            if words.count == 1{
                return words[0]
            }
            return nil
        }
        catch let error as NSError{
            throw  DataAccessError.FailFetchData(error.localizedDescription)
        }
    }
    
    func editWordEntity(wordModel: WordModel) throws{
        do{
            guard let id = wordModel.wordId else{
                throw EntityCRUDError.FailEditEntity(getEntityName())
            }
            
            if let wordEntity = try fetchEntity(id){
                wordEntity.meaning = wordModel.meaning
                wordEntity.phrase = wordModel.phrase
                if let status = wordModel.status{
                    wordEntity.status = NSNumber(long: status)
                }
                try dataAccess.saveEntity(wordEntity)
            }
            else{
                throw DataAccessError.FailFetchData("There is no Word entity with id: \(id)")
            }
        }
        catch let error as NSError{
            throw DataAccessError.FailEditData(error.localizedDescription)
        }
    }
    
    func deleteWordEntity(wordModel: WordModel) throws{
        do{
            guard let id = wordModel.wordId else{
                throw EntityCRUDError.FailDeleteEntity(getEntityName())
            }
            
            if let wordEntity = try fetchEntity(id){
                try dataAccess.deleteEntity(wordEntity)
            }
            else{
                throw DataAccessError.FailFetchData("There is no Word entity with id: \(id)")
            }
        }
        catch let error as NSError{
            throw DataAccessError.FailDeleteData(error.localizedDescription)
        }
    }
    
    private func fetchSetEntity(setId: NSUUID) -> SetEntity?{
        do{
            return try SetDataAccess(initialContext: context).fetchEntity(setId)
        }
        catch{
            return nil
        }
    }
    
    private func setOrder() throws -> NSNumber{
        do{
            let sort = SortObject(fieldName: WordEntity.Fields.Order.rawValue, direction: SortDirectionEnum.Descending)
            let words = try fetchEntities(nil, sortProtocol: sort , fetchLimit: 1)
            if words.count > 0{
                if let order = words[0].order{
                    return NSNumber(int: order.intValue + 1)
                }
            }
            return 1
        }
        catch let error as NSError{
            throw DataAccessError.FailSaveData(error.localizedDescription)
        }
    }
    
}