//
//  CategoryDataManager.swift
//  Task app
//
//  Created by Joseph Liu on 16.03.17.
//  Copyright © 2017 Joseph Liu. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CategoryDataManager {
    
    static var sharedInstance = CategoryDataManager()
    private init() { }
    
    private let entityName = "Category"
    
    func requestListOfCategories() -> [Category]? {
        
        let fetchRequest:NSFetchRequest<Category> = Category.fetchRequest()
        
        do{
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            return searchResults
        }
        catch{
            print("Error: \(error)")
            return nil
        }
        
    }
    
    func getCategoryObjectWith(title: String, color: UIColor) -> Category {
        
        let category: Category = NSEntityDescription.insertNewObject(forEntityName: entityName, into: DatabaseController.getContext()) as! Category
        category.title = title
        category.color = color
        
        return category
        
    }
    
    func saveCategory(title: String, color: UIColor) {
        
        let category = getCategoryObjectWith(title: title, color: color)
        DatabaseController.saveContext()
    
    }
    
    func saveInitialFourCategories() {
        
        let category1 = getCategoryObjectWith(title: "Personal", color: Colors.blue)
        let category2 = getCategoryObjectWith(title: "Family", color: Colors.green)
        let category3 = getCategoryObjectWith(title: "Work", color: Colors.orange)
        let category4 = getCategoryObjectWith(title: "<3", color: Colors.red)
        
        DatabaseController.saveContext()
        
    }
}
