//
//  WordArchiveEntityCRUDTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/17/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import XCTest
import CoreData
@testable import MemorizeItForever

class WordHistoryEntityTests: XCTestCase {
    var managedObjectContext: NSManagedObjectContext?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        managedObjectContext = setUpInMemoryManagedObjectContext()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        managedObjectContext = nil
    }
    
    func testCreateANewObjectOfWordHistoryEntity() {
        let entity = NSEntityDescription.insertNewObjectForEntityForName("WordHistoryEntity", inManagedObjectContext: managedObjectContext!)
        XCTAssertNotNil(entity, "Should be able to define a new WordHistory entity")
    }
    
    func testSaveANewWordHistoryEntity() {
        var result = false
        if let wordEntity = SaveWordEntity().entity{
            if let entity = NSEntityDescription.insertNewObjectForEntityForName("WordHistoryEntity", inManagedObjectContext: managedObjectContext!) as? WordHistoryEntity{
                entity.columnNo = 1
                entity.failureCount = 4
                entity.id = NSUUID().UUIDString
                entity.word = wordEntity
                do{
                    try managedObjectContext?.save()
                    result = true
                }
                catch {
                    result = false
                }
            }
        }
        XCTAssertTrue(result, "A new WordHistory entity should be saved")
    }
    
    func testCouldNotSaveANewWordHistoryWithoutIdProperty() {
        var result = false
        if let wordEntity = SaveWordEntity().entity{
            if let entity = NSEntityDescription.insertNewObjectForEntityForName("WordHistoryEntity", inManagedObjectContext: managedObjectContext!) as? WordHistoryEntity{
                entity.columnNo = 1
                entity.failureCount = 4
                entity.word = wordEntity
                do{
                    try managedObjectContext?.save()
                    result = true
                }
                catch {
                    result = false
                }
            }
        }
        
        XCTAssertFalse(result, "If id wasn't set, save method should throw an error")
    }
    
    
    func testCouldNotSaveANewWordHistoryWithoutColumnNoProperty() {
        var result = false
        if let wordEntity = SaveWordEntity().entity{
            if let entity = NSEntityDescription.insertNewObjectForEntityForName("WordHistoryEntity", inManagedObjectContext: managedObjectContext!) as? WordHistoryEntity{
                entity.failureCount = 4
                entity.word = wordEntity
                do{
                    try managedObjectContext?.save()
                    result = true
                }
                catch {
                    result = false
                }
            }
        }
        
        XCTAssertFalse(result, "If columnNo wasnt set, save method should throw an error")
    }
    
    func testCouldNotSaveANewWordHistoryWithoutFailureCountProperty() {
        var result = false
        if let wordEntity = SaveWordEntity().entity{
            if let entity = NSEntityDescription.insertNewObjectForEntityForName("WordHistoryEntity", inManagedObjectContext: managedObjectContext!) as? WordHistoryEntity{
                entity.columnNo = 1
                entity.word = wordEntity
                do{
                    try managedObjectContext?.save()
                    result = true
                }
                catch {
                    result = false
                }
            }
        }
        
        XCTAssertFalse(result, "if failureCount wasn't set, save method should throw an error")
    }
    func testCouldNotSaveANewWordHistoryWithoutWordProperty() {
        var result = false
        if let entity = NSEntityDescription.insertNewObjectForEntityForName("WordHistoryEntity", inManagedObjectContext: managedObjectContext!) as? WordHistoryEntity{
            entity.columnNo = 1
            entity.failureCount = 4
            do{
                try managedObjectContext?.save()
                result = true
            }
            catch {
                result = false
            }
        }
        
        XCTAssertFalse(result, "If word field wasnt set, save method should throw an error")
    }
    
    func testCanFetchWordHistoryEntity() {
        var result = false
        
        if SaveWordHistoryEntity().succcessful{
            let fetchRequest = NSFetchRequest(entityName: "WordHistoryEntity")
            
            do{
                if let wordHistoryEntities = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [WordHistoryEntity]{
                    if wordHistoryEntities.count > 0{
                        XCTAssertEqual(wordHistoryEntities[0].columnNo, 1, "Should be able to fetch wordHistory entity")
                        result = true
                    }
                }
            }
            catch{
                result = false
            }
        }
        
        XCTAssertTrue(result, "Should be able to fetch wordHistory entity")
    }
    
    func testCanEditWordHistoryEntity() {
        var result = false
        
        if SaveWordHistoryEntity().succcessful{
            let fetchRequest = NSFetchRequest(entityName: "WordHistoryEntity")
            
            do{
                if let wordHistoryEntities = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [WordHistoryEntity]{
                    if wordHistoryEntities.count > 0{
                        let wordHistoryEntity = wordHistoryEntities[0]
                        wordHistoryEntity.failureCount = 7
                        do{
                            try managedObjectContext?.save()
                            result = true
                        }
                        catch{
                            result = false
                        }
                    }
                }
            }
            catch{
                result = false
            }
        }
        
        let fetchRequest = NSFetchRequest(entityName: "WordHistoryEntity")
        
        do{
            if let wordHistoryEntities = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [WordHistoryEntity]{
                if wordHistoryEntities.count > 0{
                    XCTAssertEqual(wordHistoryEntities[0].failureCount, 7, "Should be able to edit wordHistory entity")
                    result = true
                    
                }
            }
        }
        catch{
            result = false
        }
        
        
        XCTAssertTrue(result, "Should be able to edit wordHistory entity")
    }
    
    func testCanDeleteWordHistoryEntity() {
        var result = false
        
        if SaveWordHistoryEntity().succcessful{
            let fetchRequest = NSFetchRequest(entityName: "WordHistoryEntity")
            
            do{
                if let wordHistoryEntities = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [WordHistoryEntity]{
                    if wordHistoryEntities.count > 0{
                        let setEntity = wordHistoryEntities[0]
                        managedObjectContext?.deleteObject(setEntity)
                        do{
                            try managedObjectContext?.save()
                            if let wordHistoryEntities2 = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [WordHistoryEntity]{
                                XCTAssertEqual(wordHistoryEntities2.count, 0, "Should be able to delete wordHistory entity")
                                result = wordHistoryEntities2.count == 0
                            }
                        }
                        catch{
                            result = false
                        }
                    }
                }
            }
            catch{
                result = false
            }
        }
        
        XCTAssertTrue(result, "Should be able to delete wordHistory entity")
    }
    
    func testToModelWorksFine(){
        let wordHistoryEntity = SaveWordHistoryEntity().entity
        do{
            let wordHistoryModel: WordHistoryModel? = try wordHistoryEntity?.toModel() as? WordHistoryModel
            XCTAssertEqual(wordHistoryEntity?.id, wordHistoryModel?.wordHistoryId?.UUIDString, "Id should provide in toModel")
            XCTAssertEqual(wordHistoryEntity?.columnNo, wordHistoryModel?.columnNo, "ColumnNo should provide in toModel")
            XCTAssertEqual(wordHistoryEntity?.failureCount, wordHistoryModel?.failureCount, "FailureCount should provide in toModel")
            XCTAssertEqual(wordHistoryEntity?.word?.id, wordHistoryModel?.word?.wordId?.UUIDString, "Word should provide in toModel")
        }
        catch{
            XCTFail("ToModel should work fine")
        }
    }
    
    func testSetEntityReturnCorrectName(){
        XCTAssertEqual(WordHistoryEntity.entityName, "WordHistoryEntity", "WordHistoryEntity should retuen correct entity name")
    }
    
    func testSetEntityReturnCorrectIdField(){
        XCTAssertEqual(WordHistoryEntity.idField, "id", "WordHistoryEntity should retuen correct id field name")
    }
    
    private func SaveWordEntity() -> (succcessful: Bool, entity: WordEntity?){
        let entityCreationHelper = EntityCreationHelper()
        return entityCreationHelper.SaveWordEntity(managedObjectContext!)
    }
    private func SaveWordHistoryEntity() -> (succcessful: Bool, entity: WordHistoryEntity?){
        let entityCreationHelper = EntityCreationHelper()
        return entityCreationHelper.SaveWordHistoryEntity(managedObjectContext!)
    }
    
}
