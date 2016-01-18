//
//  RouteScheduleViewController.swift
//  UkayApp
//
//  Created by Berkay Surmeli on 1/12/16.
//  Copyright © 2016 Berkay Surmeli. All rights reserved.
//

import UIKit

class RouteScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //class variables
    var driverName = String()
    var routes = [String]()

    
    //view controller members
    @IBOutlet weak var driverNameLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet var tableView: UITableView! = UITableView()
    
    
    //view controller member actions
    @IBAction func continueButtonTouched(sender: AnyObject) {
        print(routes[0])
        let presentingViewController :UIViewController! = self.presentingViewController;
        
        self.dismissViewControllerAnimated(false) {
            // go back to MainMenuView as the eyes of the user
            presentingViewController.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    @IBAction func logOutButtonTouched(sender: AnyObject) {
        performSegueWithIdentifier("logOutSegue", sender: self)
    }
    //Action when a new date is selected
    @IBAction func dateChanged(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let date = dateFormatter.stringFromDate(datePicker.date)
        let serverConnection = ServerConnection(object: self)
        serverConnection.getRoutes(date, driver: self.driverName)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        driverNameLabel.text = driverName
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let date = dateFormatter.stringFromDate(datePicker.date)
        let serverConnection = ServerConnection(object: self)
        serverConnection.getRoutes(date, driver: self.driverName)
        
        
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
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
