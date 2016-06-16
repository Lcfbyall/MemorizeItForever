//
//  WordHistoryTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 3/22/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import XCTest
@testable import MemorizeItForever

class WordHistoryTests: XCTestCase {
    var wordHistory: WordHistoryModel?
    var word: WordModel?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        word = WordModel()
        word!.phrase = "book"
        word!.meaning = "livre"
        wordHistory = WordHistoryModel()
        wordHistory!.word = word
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        wordHistory = nil
        word = nil
    }
    
    func testWordHistoryHasWord() {
        XCTAssertEqual(wordHistory!.word, self.word!, "WordHistory should provide word field")
    }
    
    func testWordHistoryHasColumnNo() {
        wordHistory!.columnNo = 1
        XCTAssertEqual(wordHistory!.columnNo,  1, "WordHistory should provide columnNo field")
    }
    
    func testWordHistoryHasFailCount() {
        wordHistory!.failureCount = 1
        XCTAssertEqual(wordHistory!.failureCount,  1, "WordHistory should provide failCount field")
    }
    
    func testWordHistoryHasId(){
        let id = NSUUID()
        wordHistory!.wordHistoryId = id
        XCTAssertEqual(wordHistory!.wordHistoryId, id, "WordHistory should provide wordHistoryId field")
    }

}
