//
//  ChooseCategoryTableViewController.swift
//  Task app
//
//  Created by Joseph Liu on 14.03.17.
//  Copyright © 2017 Joseph Liu. All rights reserved.
//

import UIKit

protocol ChooseCategoryVCDelegate {
    
    func updateCategoryIndex(index: Int)
    
}

class ChooseCategoryTableViewController: UITableViewController {
    
    var delegate: ChooseCategoryVCDelegate?
    var categories = [Category]()
    var index = Int()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fetchData()
        
    }
    
    func fetchData() {
        
        if let data = CategoryDataManager.sharedInstance.requestListOfCategories() {
            
            categories = data
            
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let category = categories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryCell
        cell.circleView = cell.circleView.squareToCircle()
        cell.circleView.backgroundColor = category.color as! UIColor?
        cell.titleLabel.text = category.title
        cell.titleLabel.textColor = category.color as! UIColor?
        
        if index == indexPath.row {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row != index {
            
            let tappedCell = tableView.cellForRow(at: indexPath)
            tappedCell?.accessoryType = UITableViewCellAccessoryType.checkmark
            tableView.cellForRow(at: IndexPath(row: index, section: 0))?.accessoryType = .none
            index = indexPath.row
            delegate?.updateCategoryIndex(index: index)
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    

}
