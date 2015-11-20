//
//  Login_VC.swift
//  flux
//
//  Created by Nathan Bruno on 10/11/15.
//  Copyright © 2015 Hatch. All rights reserved.
//

import UIKit

class Login_VC: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var tryAgainLabel: UILabel!
    
    var authenticatedUser: NSObject?
    
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tryAgainLabel.hidden = true
        
        //Mask the profile image into a circle with a white boarder
        profileImage.layer.cornerRadius = 24//(profileImage.frame.size.width / 2)
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 4.5
        profileImage.layer.borderColor = view.backgroundColor?.CGColor
        
        loginButton.layer.cornerRadius = 3
        loginButton.clipsToBounds = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //load last logged user from NSUserDefaults
        if let usernameDefault:AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("flux.username"){
            let passwordDefault = NSUserDefaults.standardUserDefaults().objectForKey("flux.password") as! String
            login(usernameDefault as! String, password: passwordDefault)
        }
        
        //show the keybaord on the username
        usernameTextField.becomeFirstResponder()
    }
    
    // MARK: - IBActions
    @IBAction func loginPressed(sender: UIButton) {
        login(usernameTextField.text!, password: passwordTextField.text!)
    }
    
    func login(userName:String, password:String){
        tryAgainLabel.hidden = true
        
        let user = Authenticator.authenticate(userName, password: password)
        if user.isKindOfClass(Student) {
            
            //save username to NSUserDefaults
            NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "flux.username")
            NSUserDefaults.standardUserDefaults().setObject(password, forKey: "flux.password")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            //launch Studnet Dashboard
            authenticatedUser = user
            performSegueWithIdentifier("Show Student Dashboard", sender: self)
            
        }else if user.isKindOfClass(Teacher){
            
            //save username to NSUserDefaults
            NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "flux.username")
            NSUserDefaults.standardUserDefaults().setObject(password, forKey: "flux.password")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            //launch Teacher Dashboard
            authenticatedUser = user
            performSegueWithIdentifier("Show Teacher Dashboard", sender: self)
            
        }else{
            //prompt user with login failure
            tryAgainLabel.hidden = false
        }
    }
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "Show Student Dashboard"{
            
            let dashboardVC = segue.destinationViewController as! StudentDashboard_VC
            dashboardVC.student = authenticatedUser as? Student
            
        }else if segue.identifier == "Show Teacher Dashboard"{
            
            let dashboardVC = segue.destinationViewController as! TeacherDashboard_TVC
            dashboardVC.teacher = authenticatedUser as? Teacher
        }
    }
    
    
    
    
}
