//
//  SetDataAccess.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/23/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import XCTest
@testable import MemorizeItForever

class SetDataAccessTests: XCTestCase {
    var setDataAccess: SetDataAccess?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setDataAccess = FakeSetDataAccess()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        setDataAccess = nil
    }
    
    //    func testFetchSetNumberThrows() {
    //        do{
    //            try setDataAccess!.fetchSetNumber()
    //            XCTFail("fetchSetNumber should throws an error")
    //        }
    //        catch{
    //
    //        }
    //    }
    
    func testFetchSetNumberReturnAnInteger() {
        do{
            let numberOfSets = try setDataAccess!.fetchSetNumber()
            XCTAssertNotNil(Int(numberOfSets), "fetchSetNumber should retuen an integer")
        }
        catch{
            XCTFail("fetchSetNumber should retuen an integer")
        }
    }
    
    func testSaveSetEntity(){
        var setModel = SetModel()
        setModel.name = "Default"
        do{
            try setDataAccess!.saveSetEntity(setModel)
        }
        catch{
            XCTFail("should be able to save an set")
        }
    }
    
    func testFetchSetNumberReturnCorrectNumber(){
        do{
            var setModel = SetModel()
            setModel.name = "Default"
            try setDataAccess!.saveSetEntity(setModel)
            let numberOfSets = try setDataAccess!.fetchSetNumber()
            XCTAssertEqual(numberOfSets, 1, "fetchSetNumber should retuen correct number of set stored")
        }
        catch{
            XCTFail("fetchSetNumber should retuen correct number of set stored")
        }
    }
    
    func testFetchSet(){
        do{
            var setModel = SetModel()
            setModel.name = "Default"
            try setDataAccess!.saveSetEntity(setModel)
            let sets = try setDataAccess?.fetchSets()
            XCTAssertEqual(sets!.count, 1, "should be able to fetch sets")
        }
        catch{
            XCTFail("should be able to fetch sets")
        }
    }
    
    func testFetchSetWithId(){
        do{
            var setModel = SetModel()
            setModel.name = "Default"
            try setDataAccess!.saveSetEntity(setModel)
            
            var setModel1 = SetModel()
            setModel1.name = "Default1"
            try setDataAccess!.saveSetEntity(setModel1)
            
            let sets = try setDataAccess?.fetchSets()
            let newSet = try setDataAccess?.fetchSet(sets![0].setId!)
            XCTAssertNotNil(newSet, "should be able to fetch set with Id")
        }
        catch{
            XCTFail("should be able to fetch  with Id")
        }
    }
    
    func testEditSet(){
        do{
            var setModel = SetModel()
            setModel.name = "Default"
            try setDataAccess!.saveSetEntity(setModel)
            var sets = try setDataAccess?.fetchSets()
            sets![0].name = "Edited"
            try setDataAccess!.editSetEntity(sets![0])
            let newSets = try setDataAccess?.fetchSets()
            
            XCTAssertEqual(newSets![0].name, "Edited", "Should be able to edit a set")
        }
        catch{
            XCTFail("Should be able to edit a set")
        }
    }
    
    func testDeleteSet(){
        do{
            var setModel = SetModel()
            setModel.name = "Default"
            try setDataAccess!.saveSetEntity(setModel)
            var sets = try setDataAccess?.fetchSets()
            try setDataAccess!.deleteSetEntity(sets![0])
            let newSets = try setDataAccess?.fetchSets()
            
            XCTAssertEqual(newSets!.count, 0, "Should be able to delete a set")
        }
        catch{
            XCTFail("Should be able to delete a set")
        }
    }

    
}
