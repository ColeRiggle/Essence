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
    @NSManaged public var location: String?
    @NSManaged public var createdDate: Date?
    @NSManaged public var lastReviewedDate: Date?
    @NSManaged public var category: Category?
    
    @NSManaged func addParentsObject(value: Category)
    @NSManaged func removeParentsObject(value: Category)
    @NSManaged func addParents(value: Set<Category>)
    @NSManaged func removeParents(value: Set<Category>)
}

extension Note : Identifiable {

}
