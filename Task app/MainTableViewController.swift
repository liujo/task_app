//
//  MainTableViewController.swift
//  Task app
//
//  Created by Joseph Liu on 13.03.17.
//  Copyright © 2017 Joseph Liu. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController {
    
    var tasks = [Task]()
    var tappedRow = Int()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.register(UINib(nibName: "CompletedTaskCell", bundle: nil), forCellReuseIdentifier: "completedCell")
        tableView.register(UINib(nibName: "OverdueCell", bundle: nil), forCellReuseIdentifier: "overdueCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let data = TaskDataManager.sharedInstance.requestListOfTasks() {
            
            tasks = data
            tableView.reloadData()
        }
        
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let task = tasks[indexPath.row]
        
        if task.isCompleted {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "completedCell", for: indexPath) as! CompletedTaskCell
            cell.title.text = task.title
            cell.category.text = task.category?.title
            if let color = task.category?.color as? UIColor {
                cell.fullCircleImage.tintColor = color
                cell.circleImage.tintColor = color
            }
            cell.completeButton.tag = indexPath.row
            cell.completeButton.addTarget(self, action: #selector(uncompleteTask), for: .touchUpInside)
            
            return cell
            
        } else if let dueDate = task.dueDate {
            
            if dueDate.timeIntervalSince1970 < Date().timeIntervalSince1970 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "overdueCell", for: indexPath) as! OverdueCell
                cell.title.text = task.title
                cell.category.text = task.category?.title
                if let color = task.category?.color as? UIColor {
                    cell.category.textColor = color
                    cell.circleImage.tintColor = color
                }
                cell.dueDate.text = Utils.sharedInstance.getFormattedDate(date: dueDate)
                cell.completeButton.tag = indexPath.row
                cell.completeButton.addTarget(self, action: #selector(completeTask), for: .touchUpInside)

                return cell
                
            }
            
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskCell
        cell.title.text = task.title
        if let date = task.dueDate {
            cell.date.text = Utils.sharedInstance.getFormattedDate(date: date)
        } else {
            cell.date.text = ""
            cell.date.isHidden = true
            cell.circleSeparator.isHidden = true
        }
        
        cell.category.text = task.category?.title
        
        if let color = task.category?.color as? UIColor {
            cell.category.textColor = color
            cell.completeButtonImage.tintColor = color
        }
        
        if let date = task.dueDate {
            cell.date.text = Utils.sharedInstance.getFormattedDate(date: date)
        } else {
            cell.date.text = ""
            cell.date.isHidden = true
            cell.circleSeparator.isHidden = true
        }
        cell.completeButton.tag = indexPath.row
        cell.completeButton.addTarget(self, action: #selector(completeTask), for: .touchUpInside)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 75
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let taskToDelete = tasks[indexPath.row]
            tasks.remove(at: indexPath.row)
            TaskDataManager.sharedInstance.deleteTask(task: taskToDelete)
            self.tableView.deleteRows(at: [indexPath], with: .left)
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tappedRow = indexPath.row
        self.performSegue(withIdentifier: "editTaskVC", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - task completion methods
    
    func completeTask(sender: UIButton) {
        
        TaskDataManager.sharedInstance.complete(task: tasks[sender.tag])
        tableView.reloadData()
        
    }
    
    func uncompleteTask(sender: UIButton) {
        
        TaskDataManager.sharedInstance.uncomplete(task: tasks[sender.tag])
        tableView.reloadData()
        
    }
    
    //MARK: - prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editTaskVC" {
            
            let navController = segue.destination as! UINavigationController
            let vc = navController.topViewController as! EditTaskTableViewController
            vc.task = tasks[tappedRow]
            
        }
    }
}
