//
//  ViewController.swift
//  Instagram
//
//  Created by Aurielle on 3/2/16.
//  Copyright © 2016 Aurielle. All rights reserved.
//

import UIKit
import Parse
import SCLAlertView

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func onSignIn(sender: AnyObject) {
        let username = userNameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsernameInBackground(username, password: password) { (user: PFUser?, error: NSError?) -> Void in
            if let error = error {
                print("User login failed.")
                SCLAlertView().showError("Login Failed", subTitle: "Check the username and password") // Error
                print(error.localizedDescription)
            } else {
                print("User logged in successfully")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
                // display view controller that needs to shown after successful login
            }
        }
        
    }
    
    
    @IBAction func onSignUp(sender: AnyObject) {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = userNameField.text
        newUser.email = userNameField.text
        newUser.password = passwordField.text
        
        // call sign up function on the object
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription)
                if error.code == 202 {
                    print("User name is taken")
                    SCLAlertView().showError("Username Taken", subTitle: "Choose another username") // Error
                }
            } else {
                print("User Registered successfully")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
                // manually segue to logged in view
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

