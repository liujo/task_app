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
        
        do{
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            return searchResults
        }
        catch{
            print("Error: \(error)")
            return nil
        }
        
    }
    
    func saveTask(title: String, dueDate: NSDate, showNotification: Bool, category: Category) {
        
        let task: Task = NSEntityDescription.insertNewObject(forEntityName: entityName, into: DatabaseController.getContext()) as! Task
        task.title = title
        task.dueDate = dueDate
        task.showNotification = showNotification
        task.category = category
        task.isCompleted = false
        
        DatabaseController.saveContext()
        
    }
}
