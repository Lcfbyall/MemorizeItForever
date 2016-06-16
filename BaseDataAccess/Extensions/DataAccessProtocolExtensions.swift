//
//  DataAccessProtocolExtensions.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/24/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation

extension DataAccessProtocol{
    
    public func generateId() -> String{
        return NSUUID().UUIDString
    }
    
    public func fetchEntities(predicateProtocol: PredicateProtocol?, sortProtocol: SortProtocol?,fetchLimit: Int? = nil) throws -> [T]{
        do{
            return try dataAccess.fetchEntity(predicateProtocol, sort: sortProtocol, fetchLimit: fetchLimit)
        }
        catch{
            throw EntityCRUDError.FailFetchEntity(T.entityName)
        }
    }
    
    public func fetchEntity(id: NSUUID) throws -> T? {
        var predicateProtocol: PredicateProtocol
        predicateProtocol = PredicateObject(fieldName: T.idField, operatorName: OperatorEnum.Equal, value: id.UUIDString)
        do{
            let entities = try fetchEntities(predicateProtocol, sortProtocol: nil)
            if entities.count > 1 {
                throw DataAccessError.FailFetchData("Mulitiple items returned")
            }
            else if entities.count == 1{
                return entities[0]
            }
            else{
                return nil
            }
        }
        catch{
            throw EntityCRUDError.FailFetchEntity(T.entityName)
        }
    }
    
    public func fetchModels<TModel: ModelProtocol>(predicateProtocol: PredicateProtocol?,sortProtocol: SortProtocol?, fetchLimit: Int? = nil) throws -> [TModel] {
        do{
            let entities = try fetchEntities(predicateProtocol,sortProtocol: sortProtocol,fetchLimit: fetchLimit)
            return try entities.toModels()
        }
        catch ModelError.FailCreateModel(let model){
            throw ModelError.FailCreateModel(model)
        }
        catch let error as NSError{
            throw  DataAccessError.FailFetchData(error.localizedDescription)
        }
    }
    
    public func getEntityName() -> String{
        return T.entityName
    }
}