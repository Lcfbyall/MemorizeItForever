//
//  WordHistoryEntity+CoreDataProperties.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/3/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension WordHistoryEntity {

    @NSManaged var columnNo: NSNumber?
    @NSManaged var failureCount: NSNumber?
    @NSManaged var id: String?
    @NSManaged var word: WordEntity?

}
