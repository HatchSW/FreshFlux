//
//  AppDelegate.swift
//  flux
//
//  Created by Nathan Bruno on 10/10/15.
//  Copyright © 2015 Hatch. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        self.cdh.saveContext()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        //demoData() //for testing out core data
    }

    func applicationWillTerminate(application: UIApplication) {
        self.cdh.saveContext()
    }
    
    // #pragma mark - Core Data Helper
    
    lazy var cdstore: CoreDataStore = {
        let cdstore = CoreDataStore()
        return cdstore
        }()
    
    lazy var cdh: CoreDataHelper = {
        let cdh = CoreDataHelper()
        return cdh
        }()
    
    // #pragma mark - Demo
    
    func demoStudents(){
        
    }
    
    func demoData(){
        NSLog(" ======================== ")
        NSLog(" ======== Student ======== ")
        
        let newItemNames = ["Apples", "Milk", "Bread", "Cheese", "Sausages", "Butter", "Orange Juice", "Cereal", "Coffee", "Eggs", "Tomatoes", "Fish"]
        
        // add families
        NSLog(" ======== Insert ======== ")
        
        for newItemName in newItemNames {
            let newItem: Student = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: self.cdh.backgroundContext!) as! Student
            
            newItem.firstName = newItemName
            NSLog("Inserted New Student named \(newItemName) ")
        }
        
        self.cdh.saveContext(self.cdh.backgroundContext!)
        
        //fetch students
        NSLog(" ======== Fetch ======== ")
        var error: NSError? = nil
        var fReq: NSFetchRequest = NSFetchRequest(entityName: "Student")
        
        fReq.predicate = NSPredicate(format:"firstName CONTAINS 'B' ")
        
        let sorter: NSSortDescriptor = NSSortDescriptor(key: "firstName" , ascending: false)
        fReq.sortDescriptors = [sorter]
        
        fReq.returnsObjectsAsFaults = false
        
        var result: [AnyObject]?
        do {
            result = try self.cdh.managedObjectContext.executeFetchRequest(fReq)
        } catch let nserror1 as NSError{
            error = nserror1
            result = nil
        }
        
        for resultItem in result! {
            let studentItem = resultItem as! Student
            NSLog("Found a student name with a B in it: \(studentItem.firstName) ")
        }
        
        //delete families
        NSLog(" ======== Delete ======== ")
        
        fReq = NSFetchRequest(entityName: "Student")
        do {
            result = try self.cdh.backgroundContext!.executeFetchRequest(fReq)
        } catch let nserror1 as NSError{
            error = nserror1
            result = nil
        }
        
        for resultItem in result! {
            let studentItem = resultItem as! Student
            NSLog("Deleted Student with first name \(studentItem.firstName) ")
            self.cdh.backgroundContext!.deleteObject(studentItem)
        }
        
        self.cdh.saveContext(self.cdh.backgroundContext!)
        
        NSLog(" ======== Check Delete ======== ")
        
        do {
            result = try self.cdh.managedObjectContext.executeFetchRequest(fReq)
        } catch let nserror1 as NSError{
            error = nserror1
            result = nil
        }
        if result!.isEmpty {
            NSLog("Deleted All Students")
        }
        else{
            for resultItem in result! {
                let studentItem = resultItem as! Student
                NSLog("Fetched Error Student named: \(studentItem.firstName) ")
            }
        }
    }
}

