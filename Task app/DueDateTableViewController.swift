//
//  DueDateTableViewController.swift
//  Task app
//
//  Created by Joseph Liu on 14.03.17.
//  Copyright © 2017 Joseph Liu. All rights reserved.
//

import UIKit

class DueDateTableViewController: UITableViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var dueDate: Date? {
        
        didSet {
            
            dateLabel.text = Utils.sharedInstance.getFormattedDate(date: dueDate!)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = Utils.sharedInstance.getFormattedDate(date: dueDate!)
        
    }

    @IBAction func saveButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    

}
