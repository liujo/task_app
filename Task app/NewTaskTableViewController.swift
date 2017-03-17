//
//  NewTaskTableViewController.swift
//  Task app
//
//  Created by Joseph Liu on 13.03.17.
//  Copyright © 2017 Joseph Liu. All rights reserved.
//

import UIKit
import CoreData

class NewTaskTableViewController: UITableViewController, UITextFieldDelegate {

    let defaults = UserDefaults.standard
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryCircle: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var showAlertSwitch: UISwitch!
    
    var category: Category? {
        
        didSet {
            
            categoryCircle.tintColor = category?.color as! UIColor?
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
        category = CategoryDataManager.sharedInstance.getCategoryAt(index: 0)
        if defaults.bool(forKey: StaticStrings.receiveNotificationsDefaulsKey) {
            showAlertSwitch.isEnabled = true
        } else {
            showAlertSwitch.isEnabled = false
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        titleTextField.becomeFirstResponder()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - NavBar button methods
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        if category != nil {
            
            TaskDataManager.sharedInstance.saveTask(title: titleTextField.text!, dueDate: dueDate, showAlert: showAlertSwitch.isOn, category: category!)
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }

    @IBAction func cancelButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: - UITextField delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
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

extension NewTaskTableViewController: ChooseCategoryVCDelegate {
    
    func updateCategoryIndex(index: Int) {
        self.category = CategoryDataManager.sharedInstance.getCategoryAt(index: index)
        
    }
    
}

extension NewTaskTableViewController: DueDateVCDelegate {
    
    func updateDueDate(date: Date?) {
        self.dueDate = date
    }
    
}
