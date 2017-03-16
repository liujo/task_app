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

    @NSManaged public var title: String?
    @NSManaged public var dueDate: NSDate?
    @NSManaged public var showNotification: Bool
    @NSManaged public var isCompleted: Bool
    @NSManaged public var category: Category?

}
