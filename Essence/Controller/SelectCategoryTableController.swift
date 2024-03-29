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

class SelectCategoryTableController: BaseCategoryDisplayController {
    
    var delegate: CreateCategoryDelegate?

    fileprivate let databaseService = EssenceDatabaseService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.Application.General.viewBackground
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.allowsSelection = true
        tableView.alwaysBounceVertical = false
        navigationController?.navigationBar.barStyle = .black
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleDimiss)), animated: false)
        navigationItem.leftBarButtonItem?.tintColor = UIColor.Application.General.navigationTint
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
            if let category = super.getCategory(for: indexPath) {
                categoryCell.cardCount = databaseService.getNotesForCategory(category).count
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
        
        return getCount()
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
        } else if indexPath.section == getCategoriesSection() {
            delegate?.categoryDidChange(title: (getCategory(for: indexPath))?.name ?? "")
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
        guard let name = name else { presentErrorAlert(title: "Invalid name"); return }
        
        if (name.trimmingCharacters(in: .whitespaces).isEmpty) {
            presentErrorAlert(title: "Name cannot be empty")
        } else if (databaseService.categoryExists(withName: name)) {
            presentErrorAlert(title: "That name is already taken")
            return
        }
        
        let category = NSEntityDescription.insertNewObject(forEntityName: "Category", into: SceneDelegate.persistentContainer.viewContext)
        category.setValue(name, forKey: "name")
        category.setValue(nil, forKey: "lastReviewed")
        category.setValue(0, forKey: "cardCount")
        databaseService.save()
    }
    
    @objc fileprivate func handleDimiss() {
        dismiss(animated: true)
    }
}
