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
    
    //db initializatin
    let db = try! Connection("/Users/berkay/Desktop/Objective C workstation/UkayApp/UKDB");
    
    //table initialization
    let driversTable = Table("Drivers");
    
    //column initialization
    let userName = Expression<String>("Username")
    let password = Expression<String>("Password")
    let name = Expression<String>("Name")
    
    
    func login(user: String, pass: String)->String {
        
        for driver in try! db.prepare(driversTable) {
            if (driver[userName]  == user && driver[password] == pass) {
                return driver[name];
            }
        }
        return "";
    }
}