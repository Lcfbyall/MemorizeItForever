//
//  SetTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 3/27/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import XCTest
@testable import MemorizeItForever

class SetTests: XCTestCase {
    var set: SetModel?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        set = SetModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        set = nil
    }
    
    func testSetHasSetId(){
        let id = NSUUID()
        set!.setId = id
        XCTAssertEqual(set!.setId, id, "Set should provide setId field")
    }
    
    func testSetHasName(){
        set!.name = "FrenchToEnglish"
        XCTAssertEqual(set!.name, "FrenchToEnglish", "Set should provide name field")
    }

}
