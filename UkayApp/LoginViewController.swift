//
//  LoginViewController.swift
//  UkayApp
//
//  Created by Berkay Surmeli on 1/6/16.
//  Copyright © 2016 Berkay Surmeli. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //Text field variables
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    //image view variable
    @IBOutlet weak var logoView: UIImageView!
    
    
    //class variables
    var driverName = String()

    
    //button actions
    @IBAction func clearAction(sender: AnyObject) {
        self.userNameTextField.text = ""
        self.passwordTextField.text = ""
        
    }
    
    @IBAction func loginButtonAction(sender: AnyObject) {
        let serverConnection = ServerConnection(object: self)
        //show error message if username text field is empty
        if userNameTextField.text!.isEmpty {
            let alertController = UIAlertController(title: "Error", message:
                "Please enter a valid username", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        driverName = serverConnection.login(self.userNameTextField.text!, pass: self.passwordTextField.text!)
        if driverName != "" {
            print(driverName)
            self.userNameTextField.text = ""
            self.passwordTextField.text = ""
            performSegueWithIdentifier("routeScheduleSegue", sender: self)
            
        }
        else{
            //show error message if username or password is wrong
            let alertController = UIAlertController(title: "Error", message:
                "Authorization Failded", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)

        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoView.image = UIImage (named: "images/logo.png")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destination : RouteScheduleViewController = segue.destinationViewController as! RouteScheduleViewController
        
        destination.driverName = self.driverName
        
        
        
    }
    

}
