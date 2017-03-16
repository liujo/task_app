//
//  Utils.swift
//  Task app
//
//  Created by Joseph Liu on 16.03.17.
//  Copyright © 2017 Joseph Liu. All rights reserved.
//

import Foundation

class Utils {
    
    static var sharedInstance = Utils()
    private init() { }
    
    /**
    Returns NSDate in a shortened string format, e.g. March 12, 12:00.
    */
    func getFormattedNSDate(date: NSDate) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, H:mm"
        return formatter.string(from: date as Date)
        
    }
    
    /**
     Returns Date in a shortened string format, e.g. March 12, 12:00.
     */
    func getFormattedDate(date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, H:mm"
        return formatter.string(from: date)
        
    }
    
}
