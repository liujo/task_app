//
//  Notifications.swift
//  Task app
//
//  Created by Joseph Liu on 17.03.17.
//  Copyright © 2017 Joseph Liu. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class Notifications {
    
    static var sharedInstance = Notifications()
    private init() { }
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    /** Requests user to enable notifications */
    func requestUserAuthorization() {
        
        notificationCenter.requestAuthorization(options: .alert) { (granted, error) in
            
            if !granted {
                
                print("user didnt enable local notifications")
                
            }
        }
    }
    
    /** Checks whether notifications are enabled or not */
    func areEnabled(completionHandler: @escaping (Bool) -> Void) {
        
        notificationCenter.getNotificationSettings { (settings) in
            
            if settings.authorizationStatus == .authorized {
                
                completionHandler(true)
                
            } else {
                
                completionHandler(false)
                
            }
            
        }
        
    }
    
    /** Sets up notification with the provided parameters if possible */
    func setNotification(taskTitle: String, categoryTitle: String, date: Date, taskID: String) {
        
        if Date().timeIntervalSince1970 < date.timeIntervalSince1970 {
            
            let content = UNMutableNotificationContent()
            content.title = taskTitle
            content.body = categoryTitle
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents(in: .current, from: date)
            let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
            let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
            let request = UNNotificationRequest(identifier: taskID, content: content, trigger: trigger)
            
            notificationCenter.add(request, withCompletionHandler: { (error) in
                
                if let error = error {
                    print(error)
                } else {
                    print("notification has been set")
                }
                
            })
            
        }
        
    }
    
    /**Disables notification of the provided taskID */
    func cancelNotificationWith(taskID: String) {
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [taskID])
        
    }
    
    /** Disables all notifications */
    func cancelAllNotifications() {
        
        notificationCenter.removeAllPendingNotificationRequests()
        
    }
}
