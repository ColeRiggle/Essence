//
//  BaseCategoryDisplayController.swift
//  Essence
//
//  Created by Cole Riggle on 12/17/20.
//

import UIKit
import CoreData

class BaseCategoryDisplayController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    // what type of functionality is requred:
    
    // - displaying custom cells given a provided category
    // - displaying other cells in other sections
    // - handeling clicks of each category
    
    // or might be useful:
    
    // - provide different ways to sort
    
    // how will this work?
    
    // Option B: subclass this and override important methods
    
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
}
