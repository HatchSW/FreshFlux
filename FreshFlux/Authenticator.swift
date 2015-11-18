//
//  Authenticator.swift
//  flux
//
//  Created by Nathan Bruno on 10/11/15.
//  Copyright © 2015 Hatch. All rights reserved.
//

import UIKit
import CoreData

class Authenticator: NSObject {

    //if authentication fails, method returns nil
    //if authentication succeds, method returns the user object
    class func authenticate(username: String, password: String) -> NSObject {
        
        //this is just a stub until we get all the cloudkit stuff figured out
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let newStudent: Student = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: appDelegate.cdh.backgroundContext!) as! Student
        
        newStudent.firstName = "Zane"
        newStudent.lastName = "Godfrey"
        newStudent.studentID = "099999"
        NSLog("Inserted New Student named \(newStudent) ")
        appDelegate.cdh.saveContext(appDelegate.cdh.backgroundContext!)
        return newStudent
    }
}
