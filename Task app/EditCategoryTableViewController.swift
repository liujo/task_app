//
//  EditCategoryTableViewController.swift
//  Task app
//
//  Created by Joseph Liu on 17.03.17.
//  Copyright © 2017 Joseph Liu. All rights reserved.
//

import UIKit

class EditCategoryTableViewController: UITableViewController, UITextFieldDelegate {
    
    var category: Category!

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryCircle: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.delegate = self
        refreshUI()
    }
    
    func refreshUI() {
        
        titleTextField.text = category.title
        categoryCircle.tintColor = category.color as! UIColor!
        
    }

    //MARK: - UITextField delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }

    //MARK: - button action
    
    @IBAction func doneButtonAction(_ sender: Any) {
        
        CategoryDataManager.sharedInstance.edit(category: category, withAttribute: titleTextField.text!)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.view.endEditing(true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "chooseColourVC" {
            
            let vc = segue.destination as! ChooseColourTableViewController
            vc.index = Colors.colors.index(of: category.color as! UIColor)!
            vc.delegate = self
        }
        
    }
}

extension EditCategoryTableViewController: ChooseColourVCDelegate {
    
    func updateColor(color: UIColor) {
        self.category.color = color
        refreshUI()
    }
    
}
