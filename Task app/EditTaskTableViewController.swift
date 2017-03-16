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
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryCircle: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var showAlertSwitch: UISwitch!

    var category: Category? {
        
        didSet {
            
            categoryCircle.backgroundColor = category?.color as! UIColor?
            categoryLabel.text = category?.title
            categoryLabel.textColor = category?.color as! UIColor?
            
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
        categoryCircle = categoryCircle.squareToCircle()
        category = task.category
        dueDate = task.dueDate
        showAlertSwitch.isOn = task.showAlert
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - UITextField delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    //MARK: - NavBar button methods

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

