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
 
    var showAlert = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.delegate = self
        categoryCircle = categoryCircle.squareToCircle()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        category = CategoryDataManager.sharedInstance.getCategoryAt(index: 0)
        
    }
    
    //MARK: - NavBar button actions
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        if category != nil {
            
            TaskDataManager.sharedInstance.saveTask(title: titleTextField.text!, dueDate: NSDate(), showNotification: false, category: category!)
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
    
    //MARK: - UISwitch action
    
    @IBAction func showAlertSwitchAction(_ sender: UISwitch) {
        showAlert = sender.isOn
    }
    
    //MARK: - prepareForSegue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "chooseCategoryVC" {
            
            let vc = segue.destination as! ChooseCategoryTableViewController
            if let id = category?.id {
                
                vc.index = Int(id)
                
            }
            
        }
        
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        
        print("unwind segue")
        if let sourceVC = segue.source as? ChooseCategoryTableViewController {
            
            category = CategoryDataManager.sharedInstance.getCategoryAt(index: sourceVC.index)
            
        }
        
    }
}
