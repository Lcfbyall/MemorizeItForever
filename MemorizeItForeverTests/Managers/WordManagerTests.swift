//
//  WordManagerTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/1/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import XCTest
import BaseDataAccess
@testable import MemorizeItForever

class WordManagerTests: XCTestCase {
    var wordManager: WordManager?
    var wordDataAccess: WordDataAccess?
    var context: ManagedObjectContextProtocol?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        context = InMemoryManagedObjectContext()
        wordDataAccess = FakeWordDataAccess(initialContext: context!)
        wordManager = WordManager(dataAccess: wordDataAccess!, wordInProgressDataAccess: nil, wodHistoryDataAccess: nil)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        wordDataAccess = nil
        wordManager = nil
        context = nil
    }
    
    func testSaveNewWord() {
        do{
            wordManager!.saveWord("Livre",meaninig: "Book",setId: newSetEntity(context!)!.setId!)
            let words = try wordDataAccess?.fetchWords()
            XCTAssertEqual(words?.count, 1, "Should save a new word")
        }
        catch{
            XCTFail("Should save a new word")
        }
    }
    func testEditWord() {
        do{
            wordManager!.saveWord("Livre",meaninig: "Book",setId: newSetEntity(context!)!.setId!)
            let word = try wordDataAccess?.fetchWords()[0]
            wordManager!.editWord(word!, phrase: "LivreEdited", meaninig: "BookEdited")
            let words = try wordDataAccess?.fetchWords()
            XCTAssertEqual(words![0].phrase, "LivreEdited", "Should be able to edit phrase field of a word")
            XCTAssertEqual(words![0].meaning, "BookEdited", "Should be able to edit meaning field of a word")
        }
        catch{
            XCTFail("Should be able to edit a word")
        }
    }
    
    func testDeleteWord() {
        do{
            wordManager!.saveWord("Livre",meaninig: "Book",setId: newSetEntity(context!)!.setId!)
            let word = try wordDataAccess?.fetchWords()[0]
            wordManager!.deleteWord(word!)
            let newWords = try wordDataAccess?.fetchWords()
            XCTAssertEqual(newWords?.count, 0, "Should be able to delete a word")
        }
        catch{
            XCTFail("Should be able to delete a word")
        }
    }
    
    private func newSetEntity(initialContext: ManagedObjectContextProtocol) -> SetModel?{
        return FlowHelper().NewSetModel(initialContext)
    }
}
