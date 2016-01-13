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
    let routes = ["L4(WED) WEST", "EAST COAST TRANSFER"]

    //view controller members
    @IBOutlet weak var driverNameLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var routeTable: UITableView!
    
    //view controller member actions
    @IBAction func continueButtonTouched(sender: AnyObject) {
        
    }
    @IBAction func logOutButtonTouched(sender: AnyObject) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.routeTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "routeCell")
        driverNameLabel.text = driverName
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(routeTable: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(routeTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return routes.count
    }
    
    func tableView(routeTable: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = routeTable.dequeueReusableCellWithIdentifier("routeCell", forIndexPath: indexPath) 
    
    // Configure the cell...
    cell.textLabel?.text = routes[indexPath.row]
    cell.detailTextLabel?.text = driverName
    
    return cell
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
