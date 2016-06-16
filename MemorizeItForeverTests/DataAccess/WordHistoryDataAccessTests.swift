//
//  WordHistoryDataAccessTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/3/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import XCTest
import BaseDataAccess
@testable import MemorizeItForever

class WordHistoryDataAccessTests: XCTestCase {
    
    var wordHistoryDataAccess: WordHistoryDataAccess?
    var context: ManagedObjectContextProtocol?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        context = InMemoryManagedObjectContext()
        wordHistoryDataAccess = FakeWordHistoryDataAccess(initialContext: context!)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        wordHistoryDataAccess = nil
        context = nil
    }

    func testSaveWordHistory(){
        let word = newWordModel(context!)
        var historyModel = WordHistoryModel()
        historyModel.columnNo = 3
        historyModel.failureCount = 1
        historyModel.word = word
        do{
            try wordHistoryDataAccess?.saveOrUpdateWordHistoryEntity(historyModel)
        }
        catch{
            XCTFail("should be able to save a wordHistory")
        }
    }
    
    func testFetchWordHistoryByWordIdAndColumnNo(){
        let word = newWordModel(context!)
        var historyModel = WordHistoryModel()
        historyModel.columnNo = 3
        historyModel.word = word
        do{
            try wordHistoryDataAccess?.saveOrUpdateWordHistoryEntity(historyModel)
           let newHistoryModels = try wordHistoryDataAccess!.fetchWordHistoryByWordId(historyModel)
            XCTAssertEqual(newHistoryModels[0].columnNo, 3, "columnNo should be the given data(here is 3)")
            XCTAssertEqual(newHistoryModels[0].failureCount, 1, "failureCount should be the given data(here is 1)")
        }
        catch{
            XCTFail("should be able to save a wordHistory")
        }
    }
    
    func testSaveIncrementFailureCountWordHistory(){
        let word = newWordModel(context!)
        var historyModel = WordHistoryModel()
        historyModel.columnNo = 3
        historyModel.word = word
        do{
            try wordHistoryDataAccess?.saveOrUpdateWordHistoryEntity(historyModel)
            try wordHistoryDataAccess?.saveOrUpdateWordHistoryEntity(historyModel)
            let newHistoryModels = try wordHistoryDataAccess!.fetchWordHistoryByWordId(historyModel)
            XCTAssertEqual(newHistoryModels[0].columnNo, 3, "columnNo should be the given data(here is 3)")
            XCTAssertEqual(newHistoryModels[0].failureCount, 2, "failureCount should be the given data(here is 2)")
        }
        catch{
            XCTFail("should be able to save a wordHistory")
        }
    }
    
    private func newWordModel(initialContext: ManagedObjectContextProtocol) -> WordModel?{
        return FlowHelper().NewWordModel(initialContext)
    }
}
