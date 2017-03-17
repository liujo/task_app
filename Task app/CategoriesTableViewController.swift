//
//  CategoriesTableViewController.swift
//  Task app
//
//  Created by Joseph Liu on 17.03.17.
//  Copyright © 2017 Joseph Liu. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    var categories = [Category]()
    var tappedRow = Int()

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
            tableView.reloadData()
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
        cell.circleView.tintColor = category.color as! UIColor?
        cell.titleLabel.text = category.title

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tappedRow = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "editCategoryVC", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editCategoryVC" {
            
            let navController = segue.destination as! UINavigationController
            let vc = navController.topViewController as! EditCategoryTableViewController
            vc.category = categories[tappedRow]
            
        }
        
    }
}
