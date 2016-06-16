//
//  WordInProgressDataAccessTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/2/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import XCTest
import BaseDataAccess
@testable import MemorizeItForever

class WordInProgressDataAccessTests: XCTestCase {
    
    var wordInProgressDataAccess: WordInProgressDataAccess?
    var context: ManagedObjectContextProtocol?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        context = InMemoryManagedObjectContext()
        wordInProgressDataAccess = FakeWordInProgressDataAccess(initialContext: context!)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        wordInProgressDataAccess = nil
        context = nil
    }
    
    func testSaveWordInProgress(){
        let word = newWordModel(context!)
        var inProgressModel = WordInProgressModel()
        inProgressModel.column = 0
        inProgressModel.date = NSDate()
        inProgressModel.word = word
        do{
            try wordInProgressDataAccess?.saveWordInProgressEntity(inProgressModel)
        }
        catch{
            XCTFail("should be able to save a wordInProgress")
        }
    }
    
    func testFetchWordInProgress() {
        let word = newWordModel(context!)
        var inProgressModel = WordInProgressModel()
        inProgressModel.column = 0
        inProgressModel.date = NSDate()
        inProgressModel.word = word
        do{
            try wordInProgressDataAccess?.saveWordInProgressEntity(inProgressModel)
            let wordInProgresses = try wordInProgressDataAccess?.fetchWordInProgress()
            XCTAssertEqual(wordInProgresses?.count, 1, "should be able to fetch wordInProgresses")
        }
        catch{
            XCTFail("should be able to fetch wordInProgresses")
        }
    }
    
    func testEditWordInProgress(){
        let word = newWordModel(context!)
        var inProgressModel = WordInProgressModel()
        inProgressModel.column = 0
        inProgressModel.date = NSDate()
        inProgressModel.word = word
        do{
            try wordInProgressDataAccess?.saveWordInProgressEntity(inProgressModel)
            var wordInProgresses = try wordInProgressDataAccess?.fetchWordInProgress()[0]
            wordInProgresses?.column = 2
            wordInProgresses?.date = NSDate().addDay(4)
            try wordInProgressDataAccess?.editWordInProgressEntity(wordInProgresses!)
            let newWordInProgresses = try wordInProgressDataAccess?.fetchWordInProgress()[0]
            XCTAssertEqual(newWordInProgresses!.column, 2, "should be able to edit the column field")
            XCTAssertEqual(newWordInProgresses!.date!.equalToDateWithoutTime(NSDate().addDay(4)!), true, "should be able to edit the date field")
        }
        catch{
            XCTFail("should be able to edit a wordInProgress")
        }
    }
    
    func testDeleteWordInProgresses(){
        do{
            let word = newWordModel(context!)
            var inProgressModel = WordInProgressModel()
            inProgressModel.column = 0
            inProgressModel.date = NSDate()
            inProgressModel.word = word
            try wordInProgressDataAccess?.saveWordInProgressEntity(inProgressModel)
            
            var wordInProgresses = try wordInProgressDataAccess?.fetchWordInProgress()
            
            try wordInProgressDataAccess!.deleteWordInProgressEntity(wordInProgresses![0])
            let newWordInProgresses = try wordInProgressDataAccess?.fetchWordInProgress()
            
            XCTAssertEqual(newWordInProgresses!.count, 0, "Should be able to delete a wordInProgresses")
        }
        catch{
            XCTFail("Should be able to delete a InProgresses")
        }
    }
    
    private func newWordModel(initialContext: ManagedObjectContextProtocol) -> WordModel?{
        return FlowHelper().NewWordModel(initialContext)
    }
}
