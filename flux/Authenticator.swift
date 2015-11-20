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
        
        //we need to get the app delegate in order to get the core data ManagedObjectContext
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //fetch students
        NSLog(" ======== Fetch ======== ")
        var error: NSError? = nil
        var fReq: NSFetchRequest = NSFetchRequest(entityName: "Student")
        
        fReq.predicate = NSPredicate(format:"studentID CONTAINS '\(username)' ")
        
        let sorter: NSSortDescriptor = NSSortDescriptor(key: "studentID" , ascending: false)
        fReq.sortDescriptors = [sorter]
        
        fReq.returnsObjectsAsFaults = false
        
        var result: [AnyObject]?
        do {
            result = try appDelegate.cdh.managedObjectContext.executeFetchRequest(fReq)
        } catch let nserror1 as NSError{
            error = nserror1
            result = nil
        }
        
        let student = result?.first as! Student
        if student.password == password {
            return student
        }else{
            return 0
        }
    }
}
