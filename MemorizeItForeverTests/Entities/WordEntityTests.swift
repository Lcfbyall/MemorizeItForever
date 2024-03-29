//
//  WordEntityCRUDTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/16/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import XCTest
import CoreData
@testable import MemorizeItForever

class WordEntityTests: XCTestCase {
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
    
    func testCreateANewObjectOfWordEntity() {
        let entity = NSEntityDescription.insertNewObjectForEntityForName("WordEntity", inManagedObjectContext: managedObjectContext!)
        XCTAssertNotNil(entity, "should be able to define a new Word entity")
    }
    
    func testSaveANewWordEntity() {
        var result = false
        if let setEntity = SaveSetEntity().entity{
            if let entity = NSEntityDescription.insertNewObjectForEntityForName("WordEntity", inManagedObjectContext: managedObjectContext!) as? WordEntity{
                entity.id = "1"
                entity.meaning = "book"
                entity.order = 1
                entity.phrase = "livre"
                entity.set = setEntity
                do{
                    try managedObjectContext?.save()
                    result = true
                }
                catch {
                    result = false
                }
            }
        }
        XCTAssertTrue(result, "Should be able to save a set entity")
    }
    
    func testCouldNotSaveANewWordWithoutIdProperty() {
        var result = false
        if let setEntity = SaveSetEntity().entity{
            if let entity = NSEntityDescription.insertNewObjectForEntityForName("WordEntity", inManagedObjectContext: managedObjectContext!) as? WordEntity{
                entity.meaning = "book"
                entity.order = 1
                entity.phrase = "livre"
                entity.set = setEntity
                do{
                    try managedObjectContext?.save()
                    result = true
                }
                catch{
                    result = false
                }
            }
        }
        XCTAssertFalse(result, "If id field wasn't set, save method should throw an error")
    }
    
    func testCouldNotSaveANewWordWithoutMeaningProperty() {
        var result = false
        if let setEntity = SaveSetEntity().entity{
            if let entity = NSEntityDescription.insertNewObjectForEntityForName("WordEntity", inManagedObjectContext: managedObjectContext!) as? WordEntity{
                entity.id = "1"
                entity.order = 1
                entity.phrase = "livre"
                entity.set = setEntity
                do{
                    try managedObjectContext?.save()
                    result = true
                }
                catch{
                    result = false
                }
            }
        }
        XCTAssertFalse(result, "If meaning field wasn't set, save method should throws an error")
    }
    
    func testCouldNotSaveANewWordWithoutOrderProperty() {
        var result = false
        if let setEntity = SaveSetEntity().entity{
            if let entity = NSEntityDescription.insertNewObjectForEntityForName("WordEntity", inManagedObjectContext: managedObjectContext!) as? WordEntity{
                entity.id = "1"
                entity.meaning = "book"
                entity.phrase = "livre"
                entity.set = setEntity
                do{
                    try managedObjectContext?.save()
                    result = true
                }
                catch{
                    result = false
                }
            }
        }
        XCTAssertFalse(result, "If order field wasn't set, save method should throws an error")
    }
    
    func testCouldNotSaveANewWordWithoutPhraseProperty() {
        var result = false
        if let setEntity = SaveSetEntity().entity{
            if let entity = NSEntityDescription.insertNewObjectForEntityForName("WordEntity", inManagedObjectContext: managedObjectContext!) as? WordEntity{
                entity.id = "1"
                entity.meaning = "book"
                entity.order = 1
                entity.set = setEntity
                do{
                    try managedObjectContext?.save()
                    result = true
                }
                catch{
                    result = false
                }
            }
        }
        XCTAssertFalse(result, "If phrase field wasn't set, save method should throws an error")
    }
    
    func testCouldNotSaveANewWordWithoutSetProperty() {
        var result = false
        if let entity = NSEntityDescription.insertNewObjectForEntityForName("WordEntity", inManagedObjectContext: managedObjectContext!) as? WordEntity{
            entity.id = "1"
            entity.meaning = "book"
            entity.order = 1
            entity.phrase = "livre"
            do{
                try managedObjectContext?.save()
                result = true
            }
            catch{
                result = false
            }
        }
        XCTAssertFalse(result, "If set field wasn't set, save method should throws an error")
    }
    
    func testCanFetchWordEntity() {
        var result = false
        
        if SaveWordEntity().succcessful{
            let fetchRequest = NSFetchRequest(entityName: "WordEntity")
            
            do{
                if let wordEntities = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [WordEntity]{
                    if wordEntities.count > 0{
                        XCTAssertEqual(wordEntities[0].phrase, "livre", "Should be able to fetch word Entity")
                        result = true
                    }
                }
            }
            catch{
                result = false
            }
        }
        
        XCTAssertTrue(result, "Should be able to fetch Word Entity")
    }
    
    func testCanEditWordEntity() {
        var result = false
        
        if SaveWordEntity().succcessful{
            let fetchRequest = NSFetchRequest(entityName: "WordEntity")
            
            do{
                if let wordEntities = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [WordEntity]{
                    if wordEntities.count > 0{
                        let wordEntity = wordEntities[0]
                        wordEntity.phrase = "Edited word Entity"
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
        
        let fetchRequest = NSFetchRequest(entityName: "WordEntity")
        
        do{
            if let wordEntities = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [WordEntity]{
                if wordEntities.count > 0{
                    XCTAssertEqual(wordEntities[0].phrase, "Edited word Entity", "Should be able to edit Word Entity")
                    result = true
                    
                }
            }
        }
        catch{
            result = false
        }
        
        
        XCTAssertTrue(result, "Should be able to edit word entity")
    }
    
    func testStatusPropertyShouldHaveNotStartedValueWhenSaveAWord(){
        var result = false
        
        if SaveWordEntity().succcessful{
            let fetchRequest = NSFetchRequest(entityName: "WordEntity")
            
            do{
                if let wordEntities = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [WordEntity]{
                    if wordEntities.count > 0{
                        let wordEntity = wordEntities[0]
                        XCTAssertEqual(wordEntity.status?.longValue, WordStatus.NotStarted.rawValue, "Status field should have a default value NotStarted")
                        result = true
                    }
                }
            }
            catch{
                result = false
            }
        }
        
        XCTAssertTrue(result, "Status field should have a default value NotStarted")
    }
    
    func testCanEditStatusPropertyWordEntity() {
        var result = false
        
        if SaveWordEntity().succcessful{
            let fetchRequest = NSFetchRequest(entityName: "WordEntity")
            
            do{
                if let wordEntities = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [WordEntity]{
                    if wordEntities.count > 0{
                        let wordEntity = wordEntities[0]
                        wordEntity.status = NSNumber(long: WordStatus.InProgress.rawValue)
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
        
        let fetchRequest = NSFetchRequest(entityName: "WordEntity")
        
        do{
            if let wordEntities = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [WordEntity]{
                if wordEntities.count > 0{
                    XCTAssertEqual(wordEntities[0].status?.longValue, WordStatus.InProgress.rawValue, "Should be able to edit status field property")
                    result = true
                    
                }
            }
        }
        catch{
            result = false
        }
        
        
        XCTAssertTrue(result, "Should be able to edit a Word entity")
    }
    
    func testCanDeleteWordEntity() {
        var result = false
        
        if SaveWordEntity().succcessful{
            let fetchRequest = NSFetchRequest(entityName: "WordEntity")
            
            do{
                if let wordEntities = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [WordEntity]{
                    if wordEntities.count > 0{
                        let wordEntity = wordEntities[0]
                        managedObjectContext?.deleteObject(wordEntity)
                        do{
                            try managedObjectContext?.save()
                            if let wordEntities2 = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [WordEntity]{
                                XCTAssertEqual(wordEntities2.count, 0, "Should be able to delete a Word entity")
                                result = wordEntities2.count == 0
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
        
        XCTAssertTrue(result, "Should be able to delete a Word entity")
    }
    
    func testWordEntityReturnCorrectName(){
        XCTAssertEqual(WordEntity.entityName, "WordEntity", "WordEntity should retuen correct entiti name")
    }
    
    func testWordEntityReturnCorrectIdField(){
        XCTAssertEqual(WordEntity.idField, "id", "WordEntity should retuen correct id field name")
    }
    
    func testToModelWorksFine(){
        let wordEntity = SaveWordEntity().entity
        do{
            let wordModel: WordModel? = try wordEntity?.toModel() as? WordModel
            XCTAssertEqual(wordEntity?.meaning, wordModel?.meaning, "Meaning should provide in toModel")
            XCTAssertEqual(wordEntity?.order, wordModel?.order,  "Order should provide in toModel")
            XCTAssertEqual(wordEntity?.phrase, wordModel?.phrase, "Phrase should provide in toModel")
            XCTAssertEqual(wordEntity?.set?.id, wordModel?.setId?.UUIDString, "SetId should provide in toModel")
            XCTAssertEqual(wordEntity?.status?.longValue, wordModel?.status, "Status should provide in toModel")
            XCTAssertEqual(wordEntity?.id, wordModel?.wordId?.UUIDString, "wordId should provide in toModel")
        }
        catch{
            XCTFail("ToModel should work fine")
        }
    }
    
    private func SaveSetEntity() -> (succcessful: Bool, entity: SetEntity?){
        let entityCreationHelper = EntityCreationHelper()
        return entityCreationHelper.SaveSetEntity(managedObjectContext!)
    }
    
    private func SaveWordEntity() -> (succcessful: Bool, entity: WordEntity?){
        let entityCreationHelper = EntityCreationHelper()
        return entityCreationHelper.SaveWordEntity(managedObjectContext!)
    }
}
