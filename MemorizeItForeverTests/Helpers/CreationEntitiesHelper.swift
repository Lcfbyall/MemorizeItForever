//
//  CreationEntitiesHelper.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/16/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation
import CoreData
@testable import MemorizeItForever

class EntityCreationHelper{
    func SaveSetEntity(managedObjectContextShared: NSManagedObjectContext) -> (succcessful: Bool, entity: SetEntity?){
        var result = false
        if let entity = NSEntityDescription.insertNewObjectForEntityForName(Entities.SetEntity.rawValue, inManagedObjectContext: managedObjectContextShared) as? SetEntity{
            entity.id = NSUUID().UUIDString
            entity.name = "set1"
            do{
                try managedObjectContextShared.save()
                result = true
                return (result, entity)
            }
            catch{
                result = false
                return (result, entity)
            }
        }
        return (result, nil)
    }
    
    func SaveWordEntity(managedObjectContextShared: NSManagedObjectContext) -> (succcessful: Bool, entity: WordEntity?){
        var result = false
        if let setEntity = SaveSetEntity(managedObjectContextShared).entity{
            if let entity = NSEntityDescription.insertNewObjectForEntityForName("WordEntity", inManagedObjectContext: managedObjectContextShared) as? WordEntity{
                entity.id = NSUUID().UUIDString
                entity.meaning = "book"
                entity.order = 1
                entity.phrase = "livre"
                entity.set = setEntity
                do{
                    try managedObjectContextShared.save()
                    result = true
                    return (result, entity)
                }
                catch {
                    result = false
                    return (result, nil)
                }
            }
        }
        return (result, nil)
    }
    
    func SaveWordInProgressEntity(managedObjectContextShared: NSManagedObjectContext) -> (succcessful: Bool, entity: WordInProgressEntity?){
        var result = false
        if let wordEntity = SaveWordEntity(managedObjectContextShared).entity{
            if let entity = NSEntityDescription.insertNewObjectForEntityForName("WordInProgressEntity", inManagedObjectContext: managedObjectContextShared) as? WordInProgressEntity{
                entity.column = 1
                entity.date = NSDate()
                entity.id = NSUUID().UUIDString
                entity.word = wordEntity
                do{
                    try managedObjectContextShared.save()
                    result = true
                    return (result, entity)
                }
                catch {
                    result = false
                    return (result, nil)
                }
            }
        }
        return (result, nil)
    }
    
    func SaveWordHistoryEntity(managedObjectContextShared: NSManagedObjectContext) -> (succcessful: Bool, entity: WordHistoryEntity?){
        var result = false
        if let wordEntity = SaveWordEntity(managedObjectContextShared).entity{
            if let entity = NSEntityDescription.insertNewObjectForEntityForName("WordHistoryEntity", inManagedObjectContext: managedObjectContextShared) as? WordHistoryEntity{
                entity.columnNo = 1
                entity.failureCount = 4
                entity.id = NSUUID().UUIDString
                entity.word = wordEntity
                do{
                    try managedObjectContextShared.save()
                    result = true
                    return (result, entity)
                }
                catch {
                    result = false
                    return (result, nil)
                }
            }
        }
        return (result, nil)
    }
}