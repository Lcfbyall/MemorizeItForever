//
//  SetDataAccess.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/23/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//
import Foundation
import BaseDataAccess

class SetDataAccess: BaseDataAccess, DataAccessProtocol  {
    
    private var _dataAccess: GenericDataAccess<SetEntity>? = nil
    var dataAccess : GenericDataAccess<SetEntity>{
        guard let setDataAccess = _dataAccess else{
            _dataAccess = GenericDataAccess<SetEntity>(initialContext: context)
            return _dataAccess!
        }
        return setDataAccess
    }
    
    func fetchSetNumber() throws -> Int {
        
        do{
            return try dataAccess.fetchEntityCount()
        }
        catch{
            throw EntityCRUDError.FailFetchEntityCount(getEntityName())
        }
    }
    
    func saveSetEntity(setModel: SetModel) throws{
        do{
            let setEntity = try dataAccess.createNewInstance()
            setEntity.id = generateId()
            setEntity.name = setModel.name
            
            try dataAccess.saveEntity(setEntity)
        }
        catch EntityCRUDError.FailNewEntity(let entityName){
            throw EntityCRUDError.FailNewEntity(entityName)
        }
        catch{
            throw EntityCRUDError.FailSaveEntity(getEntityName())
        }
    }
    
    func editSetEntity(setModel: SetModel) throws{
        do{
            guard let id = setModel.setId else{
                throw EntityCRUDError.FailEditEntity(getEntityName())
            }
            
            if let setEntity = try fetchEntity(id){
                setEntity.name = setModel.name
                try dataAccess.saveEntity(setEntity)
            }
            else{
                throw DataAccessError.FailFetchData("There is no Set entity with id: \(id)")
            }
        }
        catch let error as NSError{
            throw DataAccessError.FailEditData(error.localizedDescription)
        }
    }
    
    func deleteSetEntity(setModel: SetModel) throws{
        do{
            guard let id = setModel.setId else{
                throw EntityCRUDError.FailDeleteEntity(getEntityName())
            }
            
            if let setEntity = try fetchEntity(id){
                try dataAccess.deleteEntity(setEntity)
            }
            else{
                throw DataAccessError.FailFetchData("There is no Set entity with id: \(id)")
            }
        }
        catch let error as NSError{
            throw DataAccessError.FailDeleteData(error.localizedDescription)
        }
    }
    
    func fetchSets() throws -> [SetModel] {
        do{
            return try fetchModels(nil, sortProtocol: nil)
        }
        catch let error as NSError{
            throw  DataAccessError.FailFetchData(error.localizedDescription)
        }
    }
    
    func fetchSet(id: NSUUID) throws -> SetModel? {
        do{
            if let set = try fetchEntity(id){
                return try set.toModel() as? SetModel
            }
            return nil
        }
        catch ModelError.FailCreateModel(let model){
            throw ModelError.FailCreateModel(model)
        }
        catch let error as NSError{
            throw  DataAccessError.FailFetchData(error.localizedDescription)
        }
    }
    
    private func fetchSets(predicateProtocol: PredicateProtocol?) throws -> [SetModel] {
        do{
            let sets = try fetchEntities(predicateProtocol, sortProtocol: nil)
            return try sets.toModels()
        }
        catch ModelError.FailCreateModel(let model){
            throw ModelError.FailCreateModel(model)
        }
        catch let error as NSError{
            throw  DataAccessError.FailFetchData(error.localizedDescription)
        }
    }
    
}
