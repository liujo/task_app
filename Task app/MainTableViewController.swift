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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskCell
        
        let task = tasks[indexPath.row]
        cell.title.text = task.title
        if let date = task.dueDate {
            //cell.date.text = Utils.sharedInstance.getFormattedNSDate(date: date)
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
    
    //MARK: - prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editTaskVC" {
            
            let navController = segue.destination as! UINavigationController
            let vc = navController.topViewController as! EditTaskTableViewController
            vc.task = tasks[tappedRow]
            
        }
    }
}
