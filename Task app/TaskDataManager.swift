//
//  TaskDataManager.swift
//  Task app
//
//  Created by Joseph Liu on 16.03.17.
//  Copyright © 2017 Joseph Liu. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class TaskDataManager {
    
    static var sharedInstance = TaskDataManager()
    private init() { }
    
    private let entityName = "Task"
    
    func requestListOfTasks() -> [Task]? {
        
        let fetchRequest:NSFetchRequest<Task> = Task.fetchRequest()
        
        var sortDescriptors = [NSSortDescriptor]()
        let titleDescriptor = NSSortDescriptor(key: "title", ascending: true)
        let dueDateDescriptor = NSSortDescriptor(key: "dueDate", ascending: true)
        let hasDueDateDescriptor = NSSortDescriptor(key: "hasDueDate", ascending: false)
        
        if UserDefaults.standard.string(forKey: StaticStrings.sortTasksUserDefaultsKey) == "Title" {
            sortDescriptors = [titleDescriptor]
        } else {
            sortDescriptors = [hasDueDateDescriptor, dueDateDescriptor, titleDescriptor]
        }
        
        fetchRequest.sortDescriptors = sortDescriptors
        
        do{
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            return searchResults
        }
        catch{
            print("Error: \(error)")
            return nil
        }
        
    }
    
    func saveTask(title: String, dueDate: Date?, showAlert: Bool, category: Category) {
        
        let task: Task = NSEntityDescription.insertNewObject(forEntityName: entityName, into: DatabaseController.getContext()) as! Task
        task.title = title
        task.dueDate = dueDate
        task.showAlert = showAlert
        task.category = category
        task.isCompleted = false
        let id = UUID().uuidString
        task.id = id
        
        if dueDate != nil {
            
            task.hasDueDate = true
            
            if showAlert {
                Notifications.sharedInstance.setNotification(taskTitle: title, categoryTitle: category.title!, date: dueDate!, taskID: id)
            }
            
        } else {
            task.hasDueDate = false
        }
        
        DatabaseController.saveContext()
        
    }
    
    func edit(task: Task, withAttributes title: String, dueDate: Date?, showAlert: Bool, category: Category) {
        
        task.title = title
        task.dueDate = dueDate
        task.showAlert = showAlert
        task.category = category
        
        if dueDate != nil {
            
            task.hasDueDate = true
            
            if showAlert {
                Notifications.sharedInstance.setNotification(taskTitle: title, categoryTitle: category.title!, date: dueDate!, taskID: task.id)
            }
            
        } else {
            task.hasDueDate = false
            Notifications.sharedInstance.cancelNotificationWith(taskID: task.id)
        }
        
        DatabaseController.saveContext()
        
    }
    
    func complete(task: Task) {
        
        task.isCompleted = true
        Notifications.sharedInstance.cancelNotificationWith(taskID: task.id)
        DatabaseController.saveContext()
        
    }
    
    func uncomplete(task: Task) {
        
        task.isCompleted = false
        if task.dueDate != nil && task.showAlert {
            Notifications.sharedInstance.setNotification(taskTitle: task.title, categoryTitle: task.category.title!, date: task.dueDate!, taskID: task.id)
        }
        DatabaseController.saveContext()
        
    }
    
    func deleteTask(task: Task) {
        
        DatabaseController.getContext().delete(task)
        Notifications.sharedInstance.cancelNotificationWith(taskID: task.id)
        DatabaseController.saveContext()
        
    }
}
