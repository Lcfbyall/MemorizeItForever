//
//  SetEntity+CoreDataProperties.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/12/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension SetEntity {

    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var words: NSSet?

}
