//
//  Section+CoreDataProperties.swift
//  flux
//
//  Created by Nathan Bruno on 10/22/15.
//  Copyright © 2015 Hatch. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Section {

    @NSManaged var period: NSNumber?
    @NSManaged var name: String?
    @NSManaged var room: String?
    @NSManaged var teacher: Teacher?
    @NSManaged var students: NSSet?

}
