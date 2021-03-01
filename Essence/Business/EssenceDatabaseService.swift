//
//  EssenceDatabase.swift
//  Essence
//
//  Created by Cole Riggle on 1/8/21.
//

import Foundation
import CoreData

struct EssenceDatabaseService {
    
    func categoryExists(withName name: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        fetchRequest.includesSubentities = false
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)

        var entitiesCount = 0

        do {
            entitiesCount = try SceneDelegate.persistentContainer.viewContext.count(for: fetchRequest)
        }
        catch {
            print("Error encountered executing fetch request: \(error)")
        }

        return entitiesCount > 0
    }
    
    func save() {
        do {
            try SceneDelegate.persistentContainer.viewContext.save()
        } catch {
            print("Error encountered saving: \(error)")
        }
    }

    func getNotesForCategory(_ category: Category) -> [Note] {
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        fetchRequest.includesSubentities = false
        fetchRequest.predicate = NSPredicate(format: "category = %@", category)
        
        return getNotes(withFetchRequest: fetchRequest)
    }
    
    func getDueNotesForCategory(_ category: Category) -> [Note] {
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        fetchRequest.includesSubentities = false
        fetchRequest.predicate = NSPredicate(format: "category = %@ AND dueDate <= %@", category, Date() as CVarArg)
        
        return getNotes(withFetchRequest: fetchRequest)
    }
    
    func getUndueNotesForCategory(_ category: Category) -> [Note] {
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        fetchRequest.includesSubentities = false
        fetchRequest.predicate = NSPredicate(format: "category = %@ AND dueDate > %@", category, Date() as CVarArg)
        
        return getNotes(withFetchRequest: fetchRequest)
    }
    
    func getDueNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        fetchRequest.includesSubentities = false
        fetchRequest.predicate = NSPredicate(format: "dueDate <= %@", Date() as CVarArg)

        return getNotes(withFetchRequest: fetchRequest)
    }
    
    func getUndueNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        fetchRequest.includesSubentities = false
        fetchRequest.predicate = NSPredicate(format: "dueDate > %@", Date() as CVarArg)

        return getNotes(withFetchRequest: fetchRequest)
    }
    
    fileprivate func getNotes(withFetchRequest request: NSFetchRequest<Note>) -> [Note] {
        let managedContext = SceneDelegate.persistentContainer.viewContext
        
        do {
            return try managedContext.fetch(request)
        } catch {
            print("Error encountered retrieving notes: \(error)")
        }
        
        return []
    }
    
    func deleteNote(_ note: Note) {
        let managedContext = SceneDelegate.persistentContainer.viewContext
        
        managedContext.delete(note)
        
        do {
            try managedContext.save()
        } catch {
            print("Error encountered deleting note: \(note)")
        }
    }
}

