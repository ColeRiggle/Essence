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
        let managedContext = SceneDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        fetchRequest.includesSubentities = false
        fetchRequest.predicate = NSPredicate(format: "category = %@", category)
        
        do {
            return try managedContext.fetch(fetchRequest)
        } catch {
            print("Error encountered retrieving notes: \(error)")
        }
        
        return []
    }
    
    func getDueNotesForCategory(_ category: Category) -> [Note] {
        let managedContext = SceneDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        fetchRequest.includesSubentities = false
        fetchRequest.predicate = NSPredicate(format: "category = %@ AND dueDate <= %@", category, Date() as CVarArg)
        
        do {
            return try managedContext.fetch(fetchRequest)
        } catch {
            print("Error encountered retrieving notes: \(error)")
        }
        
        return []
    }
    
    func getUndueNotesForCategory(_ category: Category) -> [Note] {
        let managedContext = SceneDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        fetchRequest.includesSubentities = false
        fetchRequest.predicate = NSPredicate(format: "category = %@ AND dueDate > %@", category, Date() as CVarArg)
        
        do {
            return try managedContext.fetch(fetchRequest)
        } catch {
            print("Error encountered retrieving notes: \(error)")
        }
        
        return []
    }
    
    func getDueNotes() -> [Note] {
        let managedContext = SceneDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        fetchRequest.includesSubentities = false
        
        do {
            return try managedContext.fetch(fetchRequest)
        } catch {
            print("Error encountered retrieving notes: \(error)")
        }
        
        return []
    }
}

