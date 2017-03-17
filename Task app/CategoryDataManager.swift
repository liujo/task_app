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
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        do{
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            return searchResults
        }
        catch{
            print("Error: \(error)")
            return nil
        }
        
    }
    
    private func createCategoryObjectInContext(title: String, color: UIColor, id: Int16) {
        
        let category: Category = NSEntityDescription.insertNewObject(forEntityName: entityName, into: DatabaseController.getContext()) as! Category
        category.title = title
        category.color = color
        category.id = id
        
    }
    
    func saveCategory(title: String, color: UIColor) {
        
        if let categories = requestListOfCategories() {
            
            createCategoryObjectInContext(title: title, color: color, id: Int16(categories.count))
            DatabaseController.saveContext()
            
        }
    
    }
    
    func saveInitialFourCategories() {
        
        createCategoryObjectInContext(title: "Personal", color: Colors.blue, id: 0)
        createCategoryObjectInContext(title: "Family", color: Colors.green, id: 1)
        createCategoryObjectInContext(title: "Work", color: Colors.orange, id: 2)
        createCategoryObjectInContext(title: "<3", color: Colors.red, id: 3)
        DatabaseController.saveContext()
        
    }
    
    func edit(category: Category, withAttribute title: String) {
        
        category.title = title
        DatabaseController.saveContext()
        
    }
    
    func getCategoryAt(index: Int) -> Category? {
        
        let fetchRequest:NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        do{
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            return searchResults[index]
        }
        catch{
            print("Error: \(error)")
            return nil
        }
        
    }
}
