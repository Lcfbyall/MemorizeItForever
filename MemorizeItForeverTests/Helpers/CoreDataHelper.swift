//
//  CoreDataHelper.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/13/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import CoreData

func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext{
    let managedObjectModel = NSManagedObjectModel.mergedModelFromBundles([NSBundle.mainBundle()])!
    let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    do{
        try persistentStoreCoordinator.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil)
    }
    catch{
        print("Adding in-memory persistent store failed")
    }
    
    let managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
    managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
    return managedObjectContext
}
