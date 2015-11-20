//
//  Student+CoreDataProperties.swift
//  flux
//
//  Created by Student on 11/20/15.
//  Copyright © 2015 Hatch. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Student {

    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var studentID: String?
    @NSManaged var password: String?
    @NSManaged var sections: NSSet?

}
