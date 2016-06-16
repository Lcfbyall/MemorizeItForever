//
//  MockAppDelegate.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 3/27/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit
@testable import MemorizeItForever

class MockAppDelegate: NSObject, UIApplicationDelegate{
    
    func application(application: UIApplication?, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //******** // should put whole block in main app delegate
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.objectForKey(Settings.WordSwitching.rawValue) == nil{
            defaults.setValue(true, forKey: Settings.WordSwitching.rawValue)
        }
        if defaults.objectForKey(Settings.NewWordsCount.rawValue) == nil{
            defaults.setValue(10, forKey: Settings.NewWordsCount.rawValue)
        }
        if defaults.objectForKey(Settings.JudgeMyself.rawValue) == nil{
            defaults.setValue(true, forKey: Settings.JudgeMyself.rawValue)
        }
        if defaults.colorForKey(Settings.PhraseColor.rawValue) == nil {
            defaults.setColor(UIColor.blackColor(), forKey: Settings.PhraseColor.rawValue)
        }
        if defaults.colorForKey(Settings.MeaningColor.rawValue) == nil {
            defaults.setColor(UIColor.redColor(), forKey: Settings.MeaningColor.rawValue)
        }

        
        //******** //
        
        
        return true
    }
    
}
