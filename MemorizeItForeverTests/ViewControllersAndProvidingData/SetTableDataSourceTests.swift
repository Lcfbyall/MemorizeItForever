//
//  SetTableDataSourceTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/25/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import XCTest
@testable import MemorizeItForever

class SetTableDataSourceTests: XCTestCase {
    
    var set: SetModel?
    var dataSource: MemorizeItTableDataSourceProtocol?
    var firstItemIndex: NSIndexPath?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        set = SetModel(setId: NSUUID(), name: "Default")
        dataSource = SetTableDataSource()
        dataSource!.setModels([set!])
        firstItemIndex = NSIndexPath(forItem: 0, inSection: 0)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        dataSource = nil
        firstItemIndex = nil
        set = nil
    }
    
    func testReturnOneRowForOneSet(){
        let numberOfRows = dataSource!.tableView(UITableView(), numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 1, "It should Just 1 row in tableView because we have just 1 set")
    }
    
    func testReturnTwoRowForTwoSets(){
        let set = SetModel(setId: NSUUID(), name: "Default")
        let set2 = SetModel(setId: NSUUID(), name: "Default2")
        dataSource!.setModels([set, set2])
        let numberOfRows = dataSource!.tableView(UITableView(), numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 2, "It should Just 2 row in tableView because we have just 2 sets")
    }
    
    func testEachCellHasTitleCorrespondsToSetName(){
        let cell = dataSource?.tableView(UITableView(), cellForRowAtIndexPath: firstItemIndex!)
        XCTAssertEqual(cell?.textLabel?.text, "Default", "The cell should have set name as a title")
    }
    
    func testSetTableDataSourceCanHoldAClouserForHandleTap(){
        dataSource = SetTableDataSource(handleTap: { (model) in
        })
        XCTAssertNotNil((dataSource as? SetTableDataSource)!.handleTap, "SetTableDataSource can handle an clouser for handling tap event")
    }
    
    func testHandleTapClosureIsCalledWhenTapped(){
        var tapped = false
        dataSource = SetTableDataSource(handleTap: { (model) in
            tapped = true
        })
        dataSource!.setModels([set!])
        dataSource?.tableView!(UITableView(), didSelectRowAtIndexPath: firstItemIndex!)
        XCTAssertTrue(tapped,"HandleTap clouser should be called in didSelectRowAtIndexPath action")
    }
    
    func testHandleTapClosureHasSetModelInstanceWhenTapped(){
        var setModel: SetModel? = nil
        dataSource = SetTableDataSource(handleTap: { (model) in
            setModel = model as? SetModel
        })
        dataSource!.setModels([set!])
        dataSource?.tableView!(UITableView(), didSelectRowAtIndexPath: firstItemIndex!)
        XCTAssertEqual(setModel?.name, "Default","HandleTap clouser should hold  a setModel instance")
    }
}
