//
//  ChooseColourTableViewController.swift
//  Task app
//
//  Created by Joseph Liu on 17.03.17.
//  Copyright © 2017 Joseph Liu. All rights reserved.
//

import UIKit

protocol ChooseColourVCDelegate {
    
    func updateColor(color: UIColor)
    
}


class ChooseColourTableViewController: UITableViewController {
    
    var delegate: ChooseColourVCDelegate?
    var index = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "cell")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Colors.colors.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryCell
        cell.titleLabel.text = Colors.colorNames[indexPath.row]
        cell.titleLabel.textColor = Colors.colors[indexPath.row]
        cell.circleView.tintColor = Colors.colors[indexPath.row]
        
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
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        delegate?.updateColor(color: Colors.colors[index])
        
    }

}
