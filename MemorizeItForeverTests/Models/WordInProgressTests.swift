//
//  WordInProgressTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 3/21/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import XCTest
@testable import MemorizeItForever

class WordInProgressTests: XCTestCase {
    var wordInProgress: WordInProgressModel?
    var word: WordModel?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        word = WordModel()
        word!.phrase = "book"
        word!.meaning = "livre"
        word!.wordId = NSUUID()
        wordInProgress = WordInProgressModel()
        wordInProgress!.word = word
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        wordInProgress = nil
        word = nil
    }
    
    func testWordInProgressHasWord() {
        XCTAssertEqual(wordInProgress!.word, self.word!, "WordInProgress should provide word ")
    }
    
    func testWordInProgressHasDate() {
        let date = NSDate()
        wordInProgress!.date = date
        XCTAssertEqual(wordInProgress!.date, date, "WordInProgress should provide date field")
    }
    
    func testWordInProgressHasColumn() {
        wordInProgress!.column = 1
        XCTAssertEqual(wordInProgress!.column, 1, "WordInProgress should provide column field")
    }
    
    func testWordInProgressHasId(){
        let id = NSUUID()
        wordInProgress!.wordInProgressId = id
        XCTAssertEqual(wordInProgress!.wordInProgressId, id, "WordInProgress should provide wordInProgressId field")
    }
}
