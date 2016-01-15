//
//  ServerConnection.swift
//  UkayApp
//
//  Created by Berkay Surmeli on 1/6/16.
//  Copyright © 2016 Berkay Surmeli. All rights reserved.
//

import Foundation
import SQLite

class ServerConnection {
    /*
    *
    * Class Variables
    *
    */
    //Route Schedule Service
    var rss = RouteScheduleViewController()
    //db initializatin
    let db = try! Connection("/Users/berkay/Desktop/Objective C workstation/UkayApp/UkayApp/UKDB");
    
    //table initialization
    let driversTable = Table("Drivers");
    
    //column initialization
    let userName = Expression<String>("Username")
    let password = Expression<String>("Password")
    let name = Expression<String>("Name")
    
    /*
    *
    * Constructor
    *
    */
    init(object:AnyObject){
        if let incomingObj = object as? RouteScheduleViewController {
            self.rss = incomingObj
        }
    }
    
    /*
    *
    * FUNC: GETROUTES
    *
    *
    *
    */
    func getRoutes(date:String, driver:String){
        //print ("date: \(date) , driver: \(driver)")
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://74.8.200.74:80/UkayWebApp/Tablet")!)
        request.HTTPMethod = "POST"
        let postString = "&DriverName=BerkayTablet;&Password=TabletB1;&Function=getRoutes;&date=\(date);&driver=\(driver);"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)", terminator: "")
                return
            }
            //print("Request \(request)");
            //print("response = \(response)")
            //print("data: ")
            //print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            
            var parseError: NSError?
            let parsedObject: AnyObject?
            do {
                parsedObject = try NSJSONSerialization.JSONObjectWithData(data!,
                    options: NSJSONReadingOptions.AllowFragments)
            } catch let error as NSError {
                parseError = error
                parsedObject = nil
            } catch {
                fatalError()
            }
            
            var items = [String]()
            if let obj = parsedObject as? NSDictionary {
                if (obj.count > 0){
                    for var i = 0; i<obj.count; i++ {
                        let route = obj["\(i)"] as! [String];
                        items.append(route[0]); //Route Name
                        //items.append(route[2]); //Driver Name
                        self.rss.routes = items
                        dispatch_async(dispatch_get_main_queue(), {
                            self.rss.tableView.reloadData();
                        });
                    }
                }else{
                    self.rss.routes = ["<< No route scheduled >>"]
                    dispatch_async(dispatch_get_main_queue(), {
                        self.rss.tableView.reloadData();
                    });
                    
                }
            }
            
        }
        
        task.resume()
    }
    /*
    *
    * FUNC: LOGIN
    * login process for drivers
    * Data is stored in local database
    *
    */
    func login(user: String, pass: String)->String {
        
        for driver in try! db.prepare(driversTable) {
            if (driver[userName]  == user && driver[password] == pass) {
                return driver[name];
            }
        }
        return "";
    }
}