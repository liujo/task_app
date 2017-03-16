//
//  DueDateTableViewController.swift
//  Task app
//
//  Created by Joseph Liu on 14.03.17.
//  Copyright © 2017 Joseph Liu. All rights reserved.
//

import UIKit

protocol DueDateVCDelegate {
    
    func updateDueDate(date: Date?)
    
}

class DueDateTableViewController: UITableViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    var delegate: DueDateVCDelegate?
    
    var dueDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if dueDate == nil {
            dueDate = Date()
        }
        
        dateLabel.text = Utils.sharedInstance.getFormattedDate(date: dueDate!)
        datePicker.date = dueDate!
        
    }
    
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        
        dueDate = sender.date
        dateLabel.text = Utils.sharedInstance.getFormattedDate(date: dueDate!)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            
            dueDate = nil
            saveButtonAction(self)
            
        }
        
    }

    @IBAction func saveButtonAction(_ sender: Any) {
        
        delegate?.updateDueDate(date: dueDate)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    

}
