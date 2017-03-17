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
        
        if dueDate != nil {
            task.hasDueDate = true
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
        } else {
            task.hasDueDate = false
        }
        
        DatabaseController.saveContext()
        
    }
    
    func complete(task: Task) {
        
        task.isCompleted = true
        DatabaseController.saveContext()
        
    }
    
    func uncomplete(task: Task) {
        
        task.isCompleted = false
        DatabaseController.saveContext()
        
    }
    
    func deleteTask(task: Task) {
        
        DatabaseController.getContext().delete(task)
        DatabaseController.saveContext()
        
    }
}
