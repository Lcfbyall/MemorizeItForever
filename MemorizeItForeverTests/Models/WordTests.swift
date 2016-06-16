//
//  WordTest.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 3/21/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import XCTest
@testable import MemorizeItForever

class WordTests: XCTestCase {
    var word: WordModel?
    override func setUp() {
        super.setUp()
        word = WordModel()
        word!.phrase = "book"
        word!.meaning = "livre"
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        word = nil
    }
    
    func testWordHasPhrase() {
        XCTAssertEqual(word!.phrase, "book", "Word should provide phrase field")
    }
    
    func testWordHasMeaning() {
        XCTAssertEqual(word!.meaning, "livre", "Word should provide meaning field")
    }
    
    func testWordHasOrder(){
        word!.order = 1
        XCTAssertEqual(word!.order, 1, "Word should provide order field")
    }
    
    func testWordHasWordId(){
        let id = NSUUID()
        word!.wordId = id
        XCTAssertEqual(word!.wordId, id, "Word should provide wordId field")
    }
    
    func testWordHasSetId(){
        let id = NSUUID()
        var set = SetModel()
        set.setId = id
        word!.setId = set.setId
        XCTAssertEqual(word!.setId, id, "Word should provide setId field")
    }
    
    func testWordHasStatus() {
        word!.status = WordStatus.Done.rawValue
        XCTAssertEqual(word!.status, WordStatus.Done.rawValue, "Word should provide status field")
    }
    
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
