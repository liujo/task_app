//
//  SortTasksByTableViewController.swift
//  Task app
//
//  Created by Joseph Liu on 17.03.17.
//  Copyright © 2017 Joseph Liu. All rights reserved.
//

import UIKit

class SortTasksByTableViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    var options = StaticStrings.sortTasksOptions
    var index = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let sortTasksKey = defaults.string(forKey: StaticStrings.sortTasksUserDefaultsKey)!
        index = options.index(of: sortTasksKey)!
        
    }
    
    //MARK: - tableViewData source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = options[indexPath.row]
        
        if index == indexPath.row {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if index != indexPath.row {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            tableView.cellForRow(at: IndexPath(row: index, section: 0))?.accessoryType = .none
            defaults.set(StaticStrings.sortTasksOptions[indexPath.row], forKey: StaticStrings.sortTasksUserDefaultsKey)
            index = indexPath.row
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

}
