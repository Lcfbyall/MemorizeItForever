//
//  ApplySettingsTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 3/25/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import XCTest
import UIKit
@testable import MemorizeItForever

class ApplySettingsTests: XCTestCase {
    var mockAppDelegate: MockAppDelegate?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockAppDelegate = MockAppDelegate()
        UIApplication.sharedApplication().delegate = mockAppDelegate
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey(Settings.WordSwitching.rawValue)
        defaults.removeObjectForKey(Settings.NewWordsCount.rawValue)
        defaults.removeObjectForKey(Settings.JudgeMyself.rawValue)
        defaults.removeObjectForKey(Settings.PhraseColor.rawValue)
        defaults.removeObjectForKey(Settings.MeaningColor.rawValue)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        mockAppDelegate = nil
        
    }
    func testWordSwitchingObjectShouldNotExists() {
        let defaults = NSUserDefaults.standardUserDefaults()
        XCTAssertFalse(defaults.boolForKey(Settings.WordSwitching.rawValue), "User defaults should not have word switching option")
    }
    func testWordsCountObjectShouldNotExists() {
        let defaults = NSUserDefaults.standardUserDefaults()
        XCTAssertFalse(defaults.boolForKey(Settings.NewWordsCount.rawValue), "User defaults should not have words count")
    }
    func testJudgeMyselfObjectShouldNotExists() {
        let defaults = NSUserDefaults.standardUserDefaults()
        XCTAssertFalse(defaults.boolForKey(Settings.JudgeMyself.rawValue), "User defaults should not have judge myself option")
    }
    func testExpressionColorObjectShouldNotExists() {
        let defaults = NSUserDefaults.standardUserDefaults()
        XCTAssertFalse(defaults.boolForKey(Settings.PhraseColor.rawValue), "User defaults should not have expression color option")
    }
    func testMeaningColorObjectShouldNotExists() {
        let defaults = NSUserDefaults.standardUserDefaults()
        XCTAssertFalse(defaults.boolForKey(Settings.MeaningColor.rawValue), "User defaults should not have meaning color option")
    }
    func testWordSwitchingObjectShouldExistsAfterApplicationLunched() {
        let defaults = NSUserDefaults.standardUserDefaults()
        mockAppDelegate?.application(nil, didFinishLaunchingWithOptions: nil)
        
        XCTAssertTrue(defaults.boolForKey(Settings.WordSwitching.rawValue), "Word switching option in User defaults should have value")
    }
    func testWordsCountObjectShouldExistsAfterApplicationLunched() {
        let defaults = NSUserDefaults.standardUserDefaults()
        mockAppDelegate?.application(nil, didFinishLaunchingWithOptions: nil)
        
        XCTAssertTrue(defaults.boolForKey(Settings.NewWordsCount.rawValue), "Words count option in User defaults should have value")
    }
    func testJudgeMyselfObjectShouldExistsAfterApplicationLunched() {
        let defaults = NSUserDefaults.standardUserDefaults()
        mockAppDelegate?.application(nil, didFinishLaunchingWithOptions: nil)
        
        XCTAssertTrue(defaults.boolForKey(Settings.JudgeMyself.rawValue), "Judge myself option in User defaults should have value")
    }
    func testPhraseColorObjectShouldExistsAfterApplicationLunched() {
        let defaults = NSUserDefaults.standardUserDefaults()
        mockAppDelegate?.application(nil, didFinishLaunchingWithOptions: nil)
        
        XCTAssertNotNil(defaults.colorForKey(Settings.PhraseColor.rawValue), "Phrase Color option in User defaults should have value")
    }
    func testMeaningColorObjectShouldExistsAfterApplicationLunched() {
        let defaults = NSUserDefaults.standardUserDefaults()
        mockAppDelegate?.application(nil, didFinishLaunchingWithOptions: nil)
        
        XCTAssertNotNil(defaults.colorForKey(Settings.MeaningColor.rawValue), "Meaning Color option in User defaults should have value")
    }
    func testWordSwitchingShouldHaveUsersValue() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(false, forKey: Settings.WordSwitching.rawValue)
        mockAppDelegate?.application(nil, didFinishLaunchingWithOptions: nil)
        
        XCTAssertNotNil(defaults.objectForKey(Settings.WordSwitching.rawValue) as? Bool, "Word switching object should have boolean value")
        
        XCTAssertFalse(defaults.objectForKey(Settings.WordSwitching.rawValue) as! Bool, "Word switching object should have the user setting value")
    }
    func testWordsCountShouldHaveUsersValue() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(20, forKey: Settings.NewWordsCount.rawValue)
        mockAppDelegate?.application(nil, didFinishLaunchingWithOptions: nil)
        
        XCTAssertNotNil(defaults.objectForKey(Settings.NewWordsCount.rawValue) as? Int, "Words count object should have integer value")
        XCTAssertEqual(defaults.objectForKey(Settings.NewWordsCount.rawValue) as? Int, 20,  "Words count object should have the user setting value")
    }
    func testJudgeMyselfShouldHaveUsersValue() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(false, forKey: Settings.JudgeMyself.rawValue)
        mockAppDelegate?.application(nil, didFinishLaunchingWithOptions: nil)
        
        XCTAssertNotNil(defaults.objectForKey(Settings.JudgeMyself.rawValue) as? Bool, "Judge myself count object should have boolean value")
        XCTAssertFalse(defaults.objectForKey(Settings.JudgeMyself.rawValue) as! Bool, "Judge myself object should have the user setting value")
    }
    func testPhraseColorShouldHaveUsersValue() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let color = UIColor.whiteColor()
        defaults.setColor(color, forKey: Settings.PhraseColor.rawValue)
        mockAppDelegate?.application(nil, didFinishLaunchingWithOptions: nil)
        
        XCTAssertNotNil(defaults.objectForKey(Settings.PhraseColor.rawValue), "phrase Color object should have UIColor value")
       XCTAssertEqual(defaults.colorForKey(Settings.PhraseColor.rawValue), color,  "phrase Color object should have the user setting value")
    }
    
    func testMeaningColorShouldHaveUsersValue() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let color = UIColor.blueColor()
        defaults.setColor(color, forKey: Settings.MeaningColor.rawValue)
        mockAppDelegate?.application(nil, didFinishLaunchingWithOptions: nil)
        
        XCTAssertNotNil(defaults.objectForKey(Settings.MeaningColor.rawValue), "Meaning Color object should have UIColor value")
        XCTAssertEqual(defaults.colorForKey(Settings.MeaningColor.rawValue), color,  "Meaning Color object should have the user setting value")
    }
    
}
