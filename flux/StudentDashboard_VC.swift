//
//  StudentDashboard_VC.swift
//  flux
//
//  Created by Nathan Bruno on 10/11/15.
//  Copyright © 2015 Hatch. All rights reserved.
//

import UIKit
import QuartzCore
import Foundation

class StudentDashboard_VC: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    
    var tempCourses = ["Period 1", "Period 2", "Period 3", "Period 4", "Period 5", "Period 6"]
    
    var student: Student?
    
    @IBOutlet weak var coursePicker: UIPickerView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempConfirmChoiceLabel: UILabel!
    @IBOutlet weak var checkInButton: UIButton!
    @IBOutlet weak var remainingMinutesLabel: UITextField!
    @IBOutlet weak var minutesUntilStartDescriptionLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coursePicker.dataSource = self
        coursePicker.delegate = self
        
         self.view.backgroundColor = UIColor(patternImage: UIImage(named: "studentDashboardBackground.jpeg")!)
        
        
        checkInButton.layer.cornerRadius = 15; // this value vary as per your desire
        checkInButton.clipsToBounds = true;
        
        //display student information
//        nameLabel.text = "\(student!.firstName) \(student!.lastName)"
        
        determineTimeTillSas()
        
        var helloWorldTimer = NSTimer.scheduledTimerWithTimeInterval(60.0, target: self, selector: Selector("determineTimeTillSas"), userInfo: nil, repeats: true)
        
       
    }
    
    //Mark: IBActions
    @IBAction func CheckInButtonPressed(sender: AnyObject) {
        
        //ToDo: Check student into selected class
    }
   
    @IBAction func logOutPressed(sender: AnyObject) {
        
        //remove username and password from NSUserDefaults
        NSUserDefaults.standardUserDefaults().removeObjectForKey("flux.username")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("flux.password")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func refreshEveryMinute(){
        var helloWorldTimer = NSTimer.scheduledTimerWithTimeInterval(60.0, target: self, selector: Selector("sayHello"), userInfo: nil, repeats: true)
        
        func update()
        {
            determineTimeTillSas()
        }
        
    }
    
    
    
    func determineTimeTillSas() {
        //SAS starts 9:40 am
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day, .Hour, .Minute, .Second], fromDate: date)
        let hour = components.hour;
        let minute = components.minute;
//        let second = components.second;
        
        //change text color depending on how long you have until SAS starts
        if minute <= 40 {
            let untilMinute = 40 - minute
            
            if untilMinute <= 5 {
                //red
                remainingMinutesLabel.textColor = UIColor(red: (229/255.0), green: (57/255.0), blue: (53/255.0), alpha: 1.0)

            }else{
                //green
                remainingMinutesLabel.textColor =  UIColor(red: (100/255.0), green: (221/255.0), blue: (23/255.0), alpha: 1.0)
            }
            
            remainingMinutesLabel.text = String(untilMinute)
        }else{
            //red
            remainingMinutesLabel.textColor = UIColor(red: (229/255.0), green: (57/255.0), blue: (53/255.0), alpha: 1.0)

            remainingMinutesLabel.text = "SAS has already started"
            minutesUntilStartDescriptionLabel.hidden = true
        }
 
    }
    
    
    
//    http://makeapppie.com/tag/uipickerview-in-swift/
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    //determines the number of rows in the picker
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tempCourses.count
    }
    
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tempCourses[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tempConfirmChoiceLabel.text = tempCourses[row]
    }

    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        var pickerLabel = view as! UILabel!
        if view == nil {  //if no label there yet
            pickerLabel = UILabel()
            //color the label's background
            //Hues are spaced between 0 and 1, each will give you a different background color
//            let hue = CGFloat(row)/CGFloat(tempCourses.count)
//            pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        }
        let titleData = tempCourses[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "AppleSDGothicNeo-SemiBold", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel!.attributedText = myTitle
        pickerLabel!.textAlignment = .Center
        return pickerLabel
    }
    
}
