//
//  Note+CoreDataProperties.swift
//  Essence
//
//  Created by Cole Riggle on 1/7/21.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var masteryLevel: NSNumber?
    @NSManaged public var location: String?
    @NSManaged public var dueDate: Date?
    @NSManaged public var createdDate: Date?
    @NSManaged public var lastReviewedDate: Date?
    @NSManaged public var category: Category?
    @NSManaged public var previousInterval: NSNumber?
    
    func isDue() -> Bool {
        if let dueDate = dueDate {
            return dueDate <= Date()
        }
        return false
    }
}

extension Note : Identifiable {

}
