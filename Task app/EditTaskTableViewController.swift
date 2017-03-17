//
//  EditTaskTableViewController.swift
//  Task app
//
//  Created by Joseph Liu on 14.03.17.
//  Copyright © 2017 Joseph Liu. All rights reserved.
//

import UIKit

class EditTaskTableViewController: UITableViewController, UITextFieldDelegate {
    
    var task: Task!
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryCircle: UIImageView!
    @IBOutlet weak var completeButtonCircleImage: UIImageView!
    @IBOutlet weak var completeButtonFullCircleImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var showAlertSwitch: UISwitch!
    
    var category: Category? {
        
        didSet {
            
            completeButtonCircleImage.tintColor = category?.color as! UIColor?
            categoryCircle.tintColor = category?.color as! UIColor?
            categoryLabel.text = category?.title
            categoryLabel.textColor = category?.color as! UIColor?
            
            if task.isCompleted {
                completeButtonFullCircleImage.tintColor = category?.color as! UIColor?
            } else {
                completeButtonFullCircleImage.tintColor = UIColor.clear
            }
            
        }
        
    }
    
    var dueDate: Date? {
        
        didSet {
            
            if dueDate != nil {
                
                dueDateLabel.text = Utils.sharedInstance.getFormattedDate(date: dueDate!)
                
            } else {
                
                dueDateLabel.text = ""
                
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        titleTextField.delegate = self
        titleTextField.text = task.title
        category = task.category
        dueDate = task.dueDate
        if defaults.bool(forKey: StaticStrings.receiveNotificationsDefaulsKey) {
            showAlertSwitch.isOn = task.showAlert
            showAlertSwitch.isEnabled = true
        } else {
            showAlertSwitch.isOn = false
            showAlertSwitch.isEnabled = false
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - UITextField delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    //MARK: - button methods
    
    @IBAction func confirmButtonAction(_ sender: Any) {
        
        if task.isCompleted {
            completeButtonFullCircleImage.tintColor = UIColor.clear
            task.isCompleted = false
        } else {
            completeButtonFullCircleImage.tintColor = category?.color as! UIColor?
            task.isCompleted = true
        }
        
    }
    

    @IBAction func doneButtonAction(_ sender: Any) {
        
        if category != nil {
            
            TaskDataManager.sharedInstance.edit(task: task, withAttributes: titleTextField.text!, dueDate: dueDate, showAlert: showAlertSwitch.isOn, category: category!)
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Delete task?", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            
            TaskDataManager.sharedInstance.deleteTask(task: self.task)
            self.dismiss(animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - prepareForSegue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "chooseCategoryVC" {
            
            let vc = segue.destination as! ChooseCategoryTableViewController
            vc.delegate = self
            if let id = category?.id {
                
                vc.index = Int(id)
                
            }
            
        } else if segue.identifier == "dueDateVC" {
            
            let vc = segue.destination as! DueDateTableViewController
            vc.delegate = self
            if dueDate != nil {
                
                vc.dueDate = dueDate
                
            }
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.view.endEditing(true)
        
    }

}

extension EditTaskTableViewController: ChooseCategoryVCDelegate {
    
    func updateCategoryIndex(index: Int) {
        
        self.category = CategoryDataManager.sharedInstance.getCategoryAt(index: index)
        
    }
    
}

extension EditTaskTableViewController: DueDateVCDelegate {
    
    func updateDueDate(date: Date?) {
        self.dueDate = date
    }
    
}

