//
//  SetManagerTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/24/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import XCTest
@testable import MemorizeItForever

class SetManagerTests: XCTestCase {
    
    var setManager: SetManager?
    var setDataAccess: SetDataAccess?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setDataAccess = FakeSetDataAccess()
        setManager = SetManager(dataAccess: setDataAccess!)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        setManager = nil
        setDataAccess = nil
    }
    
    func testCreateDefaultSetIfDoesNotExists() {
        do{
            setManager!.CreateDefaultSet()
            let number = try setDataAccess?.fetchSetNumber()
            XCTAssertEqual(number, 1, "Should create a default set if does not exist")
        }
        catch{
            XCTFail("Should create a default set if does not exist")
        }
    }
    
    func testDoNotCreateDefaultSetIfSetExists() {
        do{
            var model = SetModel()
            model.name = "EnglishToFrench"
            try setDataAccess?.saveSetEntity(model)
            setManager!.CreateDefaultSet()
            let number = try setDataAccess?.fetchSetNumber()
            XCTAssertEqual(number, 1, "Should create a default set if does not exist")
        }
        catch{
            XCTFail("Should create a default set if does not exist")
        }
    }
    
    func testSaveNewSet() {
        do{
            setManager!.saveSet("EnglishToFrench")
            let number = try setDataAccess?.fetchSetNumber()
            XCTAssertEqual(number, 1, "Should save a new set")
        }
        catch{
            XCTFail("Should save a new set")
        }
    }
    
    func testEditSet() {
        do{
            var model = SetModel()
            model.name = "EnglishToFrench"
            try setDataAccess?.saveSetEntity(model)
            let fetchedSet = try setDataAccess?.fetchSets()[0]
            setManager!.editSet(fetchedSet!, setName: "EnglishToFrenchEdited")
            let sets = try setDataAccess?.fetchSets()
            XCTAssertEqual(sets![0].name, "EnglishToFrenchEdited", "Should be able to edit name field of a set")
        }
        catch{
            XCTFail("Should be able to edit a set")
        }
    }
    
    func testDeleteSet() {
        do{
            var model = SetModel()
            model.name = "EnglishToFrench"
            try setDataAccess?.saveSetEntity(model)
            let fetchedSet = try setDataAccess?.fetchSets()[0]
            setManager!.deleteSet(fetchedSet!)
            let sets = try setDataAccess?.fetchSets()
            XCTAssertEqual(sets?.count, 0, "Should be able to delete a set")
        }
        catch{
            XCTFail("Should be able to delete a set")
        }
    }

}
