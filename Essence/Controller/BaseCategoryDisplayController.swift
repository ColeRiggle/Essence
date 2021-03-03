//
//  BaseCategoryDisplayController.swift
//  Essence
//
//  Created by Cole Riggle on 12/17/20.
//

import UIKit
import CoreData

protocol BaseCategoryDisplayDelegate {
    func categoryDeleted(category: Category)
}

class BaseCategoryDisplayController: UITableViewController, NSFetchedResultsControllerDelegate {

    var baseCategoryDisplayDelegate: BaseCategoryDisplayDelegate?
    
    fileprivate let databaseService = EssenceDatabaseService()
    
    lazy var fetchedResultsController: NSFetchedResultsController<Category> = {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: SceneDelegate.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let error = error
            print("Unable to perform fetch request: \(error)")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func getCategoriesSection() -> Int {
        return 1
    }
    
    // The following two functions are used to convert between the indexpaths used in the fetched results container
    // and in the table view more broadly
    
    final func convertIndexPathFromFetchedResultsContainer(for indexPath: IndexPath) -> IndexPath {
        return .init(row: indexPath.row, section: getCategoriesSection())
    }
    
    final func convertIndexPathForFetchedResultsContainer(for indexPath: IndexPath) -> IndexPath {
        return .init(row: indexPath.row, section: 0)
    }
    
    final func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.performBatchUpdates({
                    tableView.setContentOffset(self.tableView.contentOffset, animated: false)
                    tableView.insertRows(at: [convertIndexPathFromFetchedResultsContainer(for: indexPath)], with: .right)
                }, completion: nil)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [convertIndexPathFromFetchedResultsContainer(for: indexPath)], with: .fade)
            }
        default:
            print("")
        }
    }
    
    final func getCount() -> Int {
        guard let quotes = fetchedResultsController.fetchedObjects else { return 0 }
        return quotes.count
    }
    
    final func getCategory(for indexPath: IndexPath) -> Category? {
        return fetchedResultsController.exceptionFreeObject(at: convertIndexPathForFetchedResultsContainer(for: indexPath) as NSIndexPath) as! Category?
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            if let sessions = fetchedResultsController.fetchedObjects as [Category]? {
                fetchedResultsController.managedObjectContext.delete(sessions[indexPath.row])
                do {
                    try fetchedResultsController.managedObjectContext.save()
                } catch {
                    print("Error occured while handeling deletion: \(error)")
                }
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        var actions: [UIContextualAction] = []
        
        if canDelete(forRowAt: indexPath) {
            let modifyAction = UIContextualAction(style: .destructive, title:  "Delete", handler: { [weak self] (contextualAction, view, success) in
                self?.showDeleteWarning(forRowAt: indexPath, success: success)
            })
            actions.append(modifyAction)
        }
        
        return UISwipeActionsConfiguration(actions: actions)
    }
    
    func showDeleteWarning(forRowAt indexPath: IndexPath, success: @escaping ((Bool) -> Void)) {
        let confirmationAlert = UIAlertController(title: "Delete Category?", message: "This category and its notes will be permanently deleted.", preferredStyle: .alert)
        
        confirmationAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            success(true)
        }))
        
        confirmationAlert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] (_) in
            if let self = self {
                if let category = self.getCategory(for: indexPath) {
                    self.databaseService.clearCategory(category)
                    self.tableView(self.tableView, commit: .delete, forRowAt: indexPath)
                    self.baseCategoryDisplayDelegate?.categoryDeleted(category: category)
                }
                
            }
            success(true)
        }))
        
        self.present(confirmationAlert, animated: true)
    }
    
    func canDelete(forRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == getCategoriesSection()
    }
}
