//
//  CreateCategoryTableViewController.swift
//  Task app
//
//  Created by Joseph Liu on 14.03.17.
//  Copyright © 2017 Joseph Liu. All rights reserved.
//

import UIKit

class CreateCategoryTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var circleView: UIImageView!
    
    var color = Colors.red {
        
        didSet {
            
            circleView.tintColor = color
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        circleView.tintColor = color
        titleTextField.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        titleTextField.becomeFirstResponder()
        
    }
    
    //MARK: - UITextField delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }

    @IBAction func saveButtonAction(_ sender: Any) {
        
        CategoryDataManager.sharedInstance.saveCategory(title: titleTextField.text!, color: color)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.view.endEditing(true)
        
    }
    
    //MARK: - prepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseColourVC" {
            
            let vc = segue.destination as! ChooseColourTableViewController
            vc.delegate = self
            vc.index = Colors.colors.index(of: color)!
            
        }
    }

}

extension CreateCategoryTableViewController: ChooseColourVCDelegate {
    
    func updateColor(color: UIColor) {
        self.color = color
    }
    
}
