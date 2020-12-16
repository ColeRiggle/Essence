//
//  Category+CoreDataProperties.swift
//  Essence
//
//  Created by Cole Riggle on 12/14/20.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var lastReviewed: Date?
    @NSManaged public var cardCount: Int16

}

extension Category : Identifiable {

}
