//
//  GenericDataAccess.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/20/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit
import CoreData

final public class GenericDataAccess<T where T: EntityProtocol, T: AnyObject> {
    
    private let context: ManagedObjectContextProtocol
    
    private var managedObjectContext: NSManagedObjectContext{
        return context.managedObjectContext
    }
    
    public init(initialContext: ManagedObjectContextProtocol){
        context = initialContext
    }
    
    private func getName() -> String{
        return T.entityName
    }
    
    public func createNewInstance() throws -> T{
        let entityName = getName()
        
        if let entity =  NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: managedObjectContext) as? T{
            return entity
        }
        
        throw EntityCRUDError.FailNewEntity(entityName)
    }
    
    public func saveEntity(entity: T) throws{
        
        do{
            try managedObjectContext.save()
        }
        catch let error as NSError  {
            throw EntityCRUDError.FailSaveEntity(error.localizedDescription)
        }
        
    }
    
    public func fetchEntity(predicate: PredicateProtocol? = nil,sort: SortProtocol? = nil, fetchLimit: Int? = nil) throws -> [T]{
        
        let entityName = getName()
        
        let fetchRequest = NSFetchRequest(entityName: entityName)
        
        fetchRequest.predicate = predicate?.toNSPredicate()
        
        fetchRequest.sortDescriptors = sort?.toNSSortDescriptor()
        
        if let fetchLimit = fetchLimit{
            fetchRequest.fetchLimit = fetchLimit
        }
        
        do{
            if let entities = try managedObjectContext.executeFetchRequest(fetchRequest) as? [T]{
                return entities
            }
            throw EntityCRUDError.FailFetchEntity(getName())
        }
        catch{
            throw EntityCRUDError.FailFetchEntity(getName())
        }
        
    }
    
    public func fetchEntityCount(predicate: PredicateProtocol? = nil) throws -> Int{
        
        let entityName = getName()
        
        let fetchRequest = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = predicate?.toNSPredicate()
        var error: NSError?
        
        let count = managedObjectContext.countForFetchRequest(fetchRequest, error: &error)
        if error != nil{
            throw EntityCRUDError.FailFetchEntityCount(getName())
        }
        return count
    }
    
    public func deleteEntity(entity: T) throws{
        
        if let entity = entity as? NSManagedObject{
            managedObjectContext.deleteObject(entity)
            
            do{
                try managedObjectContext.save()
                
            }
            catch{
                throw EntityCRUDError.FailDeleteEntity(self.getName())
            }
        }
    }
}
