//
//  LoginViewController.swift
//  UkayApp
//
//  Created by Berkay Surmeli on 1/6/16.
//  Copyright © 2016 Berkay Surmeli. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //Route Schedule components
    @IBOutlet weak var routeScheduleLabel: UILabel!
    @IBOutlet weak var driverLabel: UILabel!
    @IBOutlet weak var emptyDriverLabel: UILabel!
    @IBOutlet weak var selectRouteLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!

    //Text field variables
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    //image view variable
    @IBOutlet weak var logoView: UIImageView!
    
    //class variables
    var driverName = String()
    var routes = [String]()

    //view that holds login components
    @IBOutlet weak var loginView: UIView!
    
    //button actions
    @IBAction func clearAction(sender: AnyObject) {
        self.userNameTextField.text = ""
        self.passwordTextField.text = ""
        
    }
    
    @IBAction func dateChanged(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let date = dateFormatter.stringFromDate(datePicker.date)
        let serverConnection = ServerConnection(object: self)
        serverConnection.getRoutes(date, driver: self.driverName)
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
            UIView.animateWithDuration(1.0, animations: {
                self.loginView.center.y -= self.view.bounds.width
                self.routeScheduleLabel.alpha = 1.0
                self.driverLabel.alpha = 1.0
                self.emptyDriverLabel.alpha = 1.0
                self.selectRouteLabel.alpha = 1.0
                self.datePicker.alpha = 1.0
                self.tableView.alpha = 1.0
                self.logOutButton.alpha = 1.0
                self.continueButton.alpha = 1.0
            })
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let date = dateFormatter.stringFromDate(datePicker.date)
            let serverConnection = ServerConnection(object: self)
            serverConnection.getRoutes(date, driver: self.driverName)
            print(routes)
            emptyDriverLabel.text = driverName
            //performSegueWithIdentifier("routeScheduleSegue", sender: self)
            
        }
        else{
            //show error message if username or password is wrong
            let alertController = UIAlertController(title: "Error", message:
                "Authorization Failded", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)

        }
        
    }
    override func viewWillAppear(animated: Bool){
        routeScheduleLabel.alpha = 0.0
        driverLabel.alpha = 0.0
        emptyDriverLabel.alpha = 0.0
        selectRouteLabel.alpha = 0.0
        datePicker.alpha = 0.0
        tableView.alpha = 0.0
        self.logOutButton.alpha = 0.0
        self.continueButton.alpha = 0.0
        loginView.center.y -= view.bounds.width
    }
    override func viewDidAppear(animated: Bool){
        UIView.animateWithDuration(1.0, animations: {
            self.loginView.center.y += self.view.bounds.width
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoView.image = UIImage (named: "images/logo.png")
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.routes.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        
        cell.textLabel!.text = self.routes[indexPath.row]
        cell.textLabel?.textAlignment = .Center
        cell.textLabel!.font = UIFont(name:"Helvetica Neue", size:35)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
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
