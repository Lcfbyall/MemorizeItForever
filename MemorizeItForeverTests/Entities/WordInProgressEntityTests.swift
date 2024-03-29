//
//  WordInProgressEntityCRUDTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/16/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import XCTest
import CoreData
@testable import MemorizeItForever

class WordInProgressEntityTests: XCTestCase {
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
    
    func testCreateANewObjectOfWordInProgressEntity() {
        let entity = NSEntityDescription.insertNewObjectForEntityForName("WordInProgressEntity", inManagedObjectContext: managedObjectContext!)
        XCTAssertNotNil(entity, "Should be able to define a new wordInProgress entity")
    }
    
    func testSaveANewWordInProgressEntity() {
        var result = false
        if let wordEntity = SaveWordEntity().entity{
            if let entity = NSEntityDescription.insertNewObjectForEntityForName("WordInProgressEntity", inManagedObjectContext: managedObjectContext!) as? WordInProgressEntity{
                entity.column = 1
                entity.date = NSDate()
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
        XCTAssertTrue(result, "A new wordInProgress entity should be saved")
    }
    
    func testCouldNotSaveANewWordWithoutIdProperty() {
        var result = false
        if let wordEntity = SaveWordEntity().entity{
            if let entity = NSEntityDescription.insertNewObjectForEntityForName("WordInProgressEntity", inManagedObjectContext: managedObjectContext!) as? WordInProgressEntity{
                entity.column = 1
                entity.date = NSDate()
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
    
    func testCouldNotSaveANewWordWithoutColumnProperty() {
        var result = false
        if let wordEntity = SaveWordEntity().entity{
            if let entity = NSEntityDescription.insertNewObjectForEntityForName("WordInProgressEntity", inManagedObjectContext: managedObjectContext!) as? WordInProgressEntity{
                entity.date = NSDate()
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
        
        XCTAssertFalse(result, "If column wasn't set, save method should throw an error")
    }
    
    func testCouldNotSaveANewWordWithoutDateProperty() {
        var result = false
        if let wordEntity = SaveWordEntity().entity{
            if let entity = NSEntityDescription.insertNewObjectForEntityForName("WordInProgressEntity", inManagedObjectContext: managedObjectContext!) as? WordInProgressEntity{
                entity.column = 1
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
        
        XCTAssertFalse(result, "If date wasn't set, save method should throw an error")
    }
    
    func testCouldNotSaveANewWordWithoutWordProperty() {
        var result = false
        if let entity = NSEntityDescription.insertNewObjectForEntityForName("WordInProgressEntity", inManagedObjectContext: managedObjectContext!) as? WordInProgressEntity{
            entity.column = 1
            entity.date = NSDate()
            do{
                try managedObjectContext?.save()
                result = true
            }
            catch {
                result = false
            }
        }
        
        XCTAssertFalse(result, "If word field wasn't set, save method should throw an error")
    }
    
    func testCanFetchWordInProgressEntity() {
        var result = false
        
        if SaveWordInProgressEntity().succcessful{
            let fetchRequest = NSFetchRequest(entityName: "WordInProgressEntity")
            
            do{
                if let wordInProgressEntities = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [WordInProgressEntity]{
                    if wordInProgressEntities.count > 0{
                        XCTAssertEqual(wordInProgressEntities[0].column, 1, "Should be able to fetch wordInProgress entity")
                        result = true
                    }
                }
            }
            catch{
                result = false
            }
        }
        
        XCTAssertTrue(result, "Should be able to fetch wordInProgress entity")
    }
    
    func testCanEditWordInProgressEntity() {
        var result = false
        
        if SaveWordInProgressEntity().succcessful{
            let fetchRequest = NSFetchRequest(entityName: "WordInProgressEntity")
            
            do{
                if let wordInProgressEntities = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [WordInProgressEntity]{
                    if wordInProgressEntities.count > 0{
                        let wordInProgressEntity = wordInProgressEntities[0]
                        wordInProgressEntity.column = 2
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
        
        let fetchRequest = NSFetchRequest(entityName: "WordInProgressEntity")
        
        do{
            if let wordInProgressEntities = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [WordInProgressEntity]{
                if wordInProgressEntities.count > 0{
                    XCTAssertEqual(wordInProgressEntities[0].column, 2, "Should be able to edit wordInProgress entity")
                    result = true
                    
                }
            }
        }
        catch{
            result = false
        }
        
        
        XCTAssertTrue(result, "Should be able to edit wordInProgress entity")
    }
    
    func testCanDeleteWordInProgressEntity() {
        var result = false
        
        if SaveWordInProgressEntity().succcessful{
            let fetchRequest = NSFetchRequest(entityName: "WordInProgressEntity")
            
            do{
                if let wordInProgressEntities = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [WordInProgressEntity]{
                    if wordInProgressEntities.count > 0{
                        let setEntity = wordInProgressEntities[0]
                        managedObjectContext?.deleteObject(setEntity)
                        do{
                            try managedObjectContext?.save()
                            if let wordInProgressEntities2 = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [WordInProgressEntity]{
                                XCTAssertEqual(wordInProgressEntities2.count, 0, "Should be able to delete wordInProgress entity")
                                result = wordInProgressEntities2.count == 0
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
        
        XCTAssertTrue(result, "Should be able to delete wordInProgress entity")
    }
    
    func testToModelWorksFine(){
        let wordInProgressEntity = SaveWordInProgressEntity().entity
        do{
            let wordInProgressModel: WordInProgressModel? = try wordInProgressEntity?.toModel() as? WordInProgressModel
            XCTAssertEqual(wordInProgressEntity?.id, wordInProgressModel?.wordInProgressId?.UUIDString, "Id should provide in toModel")
            XCTAssertEqual(wordInProgressEntity?.column, wordInProgressModel?.column, "Column should provide in toModel")
            XCTAssertEqual(wordInProgressEntity?.date, wordInProgressModel?.date, "Date should provide in toModel")
            XCTAssertEqual(wordInProgressEntity?.word?.id, wordInProgressModel?.word?.wordId?.UUIDString, "Word should provide in toModel")
        }
        catch{
            XCTFail("ToModel should work fine")
        }
    }
    
    func testSetEntityReturnCorrectName(){
        XCTAssertEqual(WordInProgressEntity.entityName, "WordInProgressEntity", "WordInProgressEntity should retuen correct entity name")
    }
    
    func testSetEntityReturnCorrectIdField(){
        XCTAssertEqual(WordInProgressEntity.idField, "id", "WordInProgressEntity should retuen correct id field name")
    }
    
    private func SaveWordEntity() -> (succcessful: Bool, entity: WordEntity?){
        let entityCreationHelper = EntityCreationHelper()
        return entityCreationHelper.SaveWordEntity(managedObjectContext!)
    }
    private func SaveWordInProgressEntity() -> (succcessful: Bool, entity: WordInProgressEntity?){
        let entityCreationHelper = EntityCreationHelper()
        return entityCreationHelper.SaveWordInProgressEntity(managedObjectContext!)
    }
}
