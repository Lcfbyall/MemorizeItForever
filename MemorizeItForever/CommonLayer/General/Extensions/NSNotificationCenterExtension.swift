//
//  NSNotificationCenterExtension.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/31/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation
extension NSNotificationCenter{
    
   func postNotificationName<T>(notificationNameEnum: NotificationName, object: T?){
        self.postNotificationName(notificationNameEnum.rawValue, object: Wrapper(wrappedValue: object))
    }
    
    func addObserver(observer: AnyObject, selector aSelector: Selector, notificationNameEnum : NotificationName?, object anObject: AnyObject?){
        self.addObserver(observer, selector: aSelector, name: notificationNameEnum?.rawValue, object: anObject)
    }
}