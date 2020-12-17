//
//  CreateTableController.swift
//  Essence
//
//  Created by Cole Riggle on 11/26/20.
//

import UIKit
import CoreData

protocol CreateCategoryDelegate {
    
    func categoryDidChange(title: String)
}

class SelectCategoryTableController: UITableViewController, NSFetchedResultsControllerDelegate {

    var delegate: CreateCategoryDelegate?
    
    lazy var fetchedResultsController: NSFetchedResultsController<Category> = {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: SceneDelegate.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    fileprivate var categories = [
        SwiftCategory(name: "EECS 281", lastStudied: Date(), cardCount: 10),
        SwiftCategory(name: "Spanish Grammar", lastStudied: Date(), cardCount: 15),
        SwiftCategory(name: "Music Theory", lastStudied: Date(), cardCount: 3),
        SwiftCategory(name: "Discrete Math", lastStudied: Date(), cardCount: 32)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.Application.General.viewBackground
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.delegate = self
        tableView.alwaysBounceVertical = false
        navigationController?.navigationBar.barStyle = .black
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleDimiss)), animated: false)
        navigationItem.leftBarButtonItem?.tintColor = UIColor.Application.General.navigationTint
        
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let error = error
            print("Unable to perform fetch request: \(error)")
        }
    }
    
    fileprivate let categoriesSection = 1
    
    // The following two functions are used to convert between the indexpaths used in the fetched results container
    // and in the table view more broadly
    
    fileprivate func convertIndexPathFromFetchedResultsContainer(for indexPath: IndexPath) -> IndexPath {
        return .init(row: indexPath.row, section: categoriesSection)
    }
    
    fileprivate func convertIndexPathForFetchedResultsContainer(for indexPath: IndexPath) -> IndexPath {
        return .init(row: indexPath.row, section: 0)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = EssenceCell()
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell = CreateNewCategoryCell()
            } else if indexPath.row == 1 {
                let divider = DividerCell()
                divider.message = "Or choose an exisiting category"
                cell = divider
            }
        } else {
            let categoryCell = CreateCategoryCell()
            if let category = fetchedResultsController.exceptionFreeObject(at: convertIndexPathForFetchedResultsContainer(for: indexPath) as NSIndexPath) {
                categoryCell.cardCount = Int(category.cardCount)
                categoryCell.name = category.name
                cell = categoryCell
            }
        }
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        
        guard let quotes = fetchedResultsController.fetchedObjects else { return 0 }
        return quotes.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0 && indexPath.row == 0) {
            return 80.0
        } else if (indexPath.section == 0 && indexPath.row == 1) {
            return 50.0
        } else {
            return 100.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            handleCreateCategory()
        } else if indexPath.section == categoriesSection {
            delegate?.categoryDidChange(title: (fetchedResultsController.exceptionFreeObject(at: convertIndexPathForFetchedResultsContainer(for: indexPath) as NSIndexPath) as! Category).name ?? "")
            handleDimiss()
        }
    }
    
    fileprivate func handleCreateCategory() {
        let createAlert = UIAlertController(title: "Create Category", message: nil, preferredStyle: .alert)
        
        createAlert.addTextField{ (textField) in
            textField.placeholder = "Category name"
        }
        
        createAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        createAlert.addAction(UIAlertAction(title: "Create", style: .default, handler: { [weak self, weak createAlert] (_) in
            self?.createCategory(name: createAlert?.textFields![0].text)
        }))
        
        present(createAlert, animated: true)
    }
    
    fileprivate func createCategory(name: String?) {
        let managedContext = SceneDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Category", in: managedContext)!

        guard let name = name else { presentErrorAlert(); return }
        
        let category = NSManagedObject(entity: entity, insertInto: managedContext)
        category.setValue(name, forKey: "name")
        category.setValue(nil, forKey: "lastReviewed")
        category.setValue(0, forKey: "cardCount")
        
        do {
            try managedContext.save()
        } catch {
            print("Encountered error while saving category: \(error)")
        }
        
    }
    
    fileprivate func presentErrorAlert() {
        let alert = UIAlertController(title: "Invalid name", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc fileprivate func handleDimiss() {
        dismiss(animated: true)
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.performBatchUpdates({
                    tableView.setContentOffset(self.tableView.contentOffset, animated: false)
                    tableView.insertRows(at: [convertIndexPathFromFetchedResultsContainer(for: indexPath)], with: .right)
                }, completion: nil)
            }
            break;
        default:
            print("")
        }
        
    }
}
