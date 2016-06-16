//
//  WordDataAccessTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/30/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import XCTest
import BaseDataAccess
@testable import MemorizeItForever

class WordDataAccessTests: XCTestCase {
    var wordDataAccess: WordDataAccess?
    var context: ManagedObjectContextProtocol?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        context = InMemoryManagedObjectContext()
        wordDataAccess = FakeWordDataAccess(initialContext: context!)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        wordDataAccess = nil
        context = nil
    }
    
    func testSaveWordEntity() {
        
        var wordModel = WordModel()
        wordModel.meaning = "Book"
        wordModel.order = 1
        wordModel.phrase = "Livre"
        wordModel.setId = NewSetEntity(context!)?.setId
        do{
            try wordDataAccess!.saveWordEntity(wordModel)
        }
        catch{
            XCTFail("should be able to save a word")
        }
    }
    
    func testFetchWord(){
        do{
            var wordModel = WordModel()
            wordModel.meaning = "Book"
            wordModel.order = 1
            wordModel.phrase = "Livre"
            wordModel.setId = NewSetEntity(context!)?.setId
            try wordDataAccess!.saveWordEntity(wordModel)
            let words = try wordDataAccess?.fetchWords()
            XCTAssertEqual(words!.count, 1, "should be able to fetch words")
        }
        catch{
            XCTFail("should be able to fetch words")
        }
    }
    
    func testEditWord(){
        do{
            var wordModel = WordModel()
            wordModel.meaning = "Book"
            wordModel.order = 1
            wordModel.phrase = "Livre"
            wordModel.setId = NewSetEntity(context!)?.setId
            try wordDataAccess!.saveWordEntity(wordModel)
            
            var words = try wordDataAccess?.fetchWords()
            words![0].meaning = "Book Edited"
            words![0].phrase = "Livre Edited"
            words![0].status = WordStatus.Done.rawValue
            
            try wordDataAccess!.editWordEntity(words![0])
            let newWords = try wordDataAccess?.fetchWords()
            
            XCTAssertEqual(newWords![0].meaning, "Book Edited", "Should be able to edit the meaning field")
            XCTAssertEqual(newWords![0].phrase, "Livre Edited", "Should be able to edit the phrase field")
            XCTAssertEqual(newWords![0].status, WordStatus.Done.rawValue, "Should be able to edit the status field")
        }
        catch{
            XCTFail("Should be able to edit a word")
        }
    }
    
    func testPreventEdititingOrder(){
        do{
            var wordModel = WordModel()
            wordModel.meaning = "Book"
            wordModel.order = 1
            wordModel.phrase = "Livre"
            wordModel.setId = NewSetEntity(context!)?.setId
            try wordDataAccess!.saveWordEntity(wordModel)
            
            var words = try wordDataAccess?.fetchWords()
            words![0].order = 2
            
            try wordDataAccess!.editWordEntity(words![0])
            let newWords = try wordDataAccess?.fetchWords()
            
            XCTAssertEqual(newWords![0].order, 1, "Should prevent order field to be edited")
        }
        catch{
            XCTFail("Should prevent order field to be edited")
        }
    }
    
    func testPreventEdititingSet(){
        do{
            var wordModel = WordModel()
            wordModel.meaning = "Book"
            wordModel.order = 1
            wordModel.phrase = "Livre"
            let setId1 =  NewSetEntity(context!)?.setId
            wordModel.setId = setId1
            try wordDataAccess!.saveWordEntity(wordModel)
            
            var words = try wordDataAccess?.fetchWords()
            let setId2 = NewSetEntity(context!)?.setId
            words![0].setId = setId2
            
            try wordDataAccess!.editWordEntity(words![0])
            let newWords = try wordDataAccess?.fetchWords()
            
            XCTAssertEqual(newWords![0].setId, setId1, "Should prevent set field to be edited")
        }
        catch{
            XCTFail("Should prevent set field to be edited")
        }
    }
    
    func testDeleteWord(){
        do{
            var wordModel = WordModel()
            wordModel.meaning = "Book"
            wordModel.order = 1
            wordModel.phrase = "Livre"
            wordModel.setId = NewSetEntity(context!)?.setId
            try wordDataAccess!.saveWordEntity(wordModel)
            
            let words = try wordDataAccess?.fetchWords()
            
            try wordDataAccess!.deleteWordEntity(words![0])
            let newWords = try wordDataAccess?.fetchWords()
            
            XCTAssertEqual(newWords!.count, 0, "Should be able to delete a word")
        }
        catch{
            XCTFail("Should be able to delete a word")
        }
    }
    
    func testOrderMustSetInternallyInSave() {
        
        var wordModel = WordModel()
        wordModel.meaning = "Book"
        wordModel.phrase = "Livre"
        wordModel.setId = NewSetEntity(context!)?.setId
        do{
            try wordDataAccess!.saveWordEntity(wordModel)
        }
        catch{
            XCTFail("Order field must set internally in save method")
        }
    }
    
    func testFetchLimitWorkFine() {
        
        var wordModel = WordModel()
        wordModel.meaning = "Book"
        wordModel.phrase = "Livre"
        wordModel.setId = NewSetEntity(context!)?.setId
        
        var wordModel2 = WordModel()
        wordModel2.meaning = "Book2"
        wordModel2.phrase = "Livre2"
        wordModel2.setId = NewSetEntity(context!)?.setId
        do{
            try wordDataAccess!.saveWordEntity(wordModel)
            try wordDataAccess!.saveWordEntity(wordModel2)
            let words = try wordDataAccess?.fetchWords(fetchLimit: 1)
           
            XCTAssertEqual(words!.count, 1, "should be able to limit the number of fetching words")
        }
        catch{
            XCTFail("should be able to limit the number of fetching words")
        }
    }
    
    func testOrderingWordsShouldWorkFine() {
        
        var wordModel = WordModel()
        wordModel.meaning = "Book"
        wordModel.phrase = "Livre"
        wordModel.setId = NewSetEntity(context!)?.setId
        
        var wordModel2 = WordModel()
        wordModel2.meaning = "Book2"
        wordModel2.phrase = "Livre2"
        wordModel2.setId = NewSetEntity(context!)?.setId
        
        var wordModel3 = WordModel()
        wordModel3.meaning = "Book3"
        wordModel3.phrase = "Livre3"
        wordModel3.setId = NewSetEntity(context!)?.setId
        do{
            try wordDataAccess!.saveWordEntity(wordModel)
            try wordDataAccess!.saveWordEntity(wordModel2)
            try wordDataAccess!.saveWordEntity(wordModel3)
            let words = try wordDataAccess!.fetchWords()
            XCTAssertEqual(words.filter{$0.phrase == "Livre"}[0].order, 1,"Words ordering should work fine")
            XCTAssertEqual(words.filter{$0.phrase == "Livre2"}[0].order, 2,"Words ordering should work fine")
            XCTAssertEqual(words.filter{$0.phrase == "Livre3"}[0].order, 3,"Words ordering should work fine")
        }
        catch{
            XCTFail("Words ordering should work fine")
        }
    }
    
    private func NewSetEntity(initialContext: ManagedObjectContextProtocol) -> SetModel?{
        return FlowHelper().NewSetModel(initialContext)
    }
}
