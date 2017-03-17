//
//  Task+CoreDataProperties.swift
//  Task app
//
//  Created by Joseph Liu on 16.03.17.
//  Copyright © 2017 Joseph Liu. All rights reserved.
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task");
    }

    @NSManaged public var title: String
    @NSManaged public var dueDate: Date?
    @NSManaged public var showAlert: Bool
    @NSManaged public var isCompleted: Bool
    @NSManaged public var category: Category
    @NSManaged public var hasDueDate: Bool
    @NSManaged public var id: String

}
