//
//  CreateTableController.swift
//  Essence
//
//  Created by Cole Riggle on 11/26/20.
//

import UIKit

protocol CreateCategoryDelegate {
    
    func categoryDidChange(title: String)
}

class SelectCategoryTableController: UITableViewController {

    var delegate: CreateCategoryDelegate?
    
    fileprivate let categories = [
        Category(name: "EECS 281", lastStudied: Date(), cardCount: 10),
        Category(name: "Spanish Grammar", lastStudied: Date(), cardCount: 15),
        Category(name: "Music Theory", lastStudied: Date(), cardCount: 3),
        Category(name: "Discrete Math", lastStudied: Date(), cardCount: 32)
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
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = EssenceCell()
        
        if indexPath.row == 0 {
            cell = CreateNewCategoryCell()
        } else if indexPath.row == 1 {
            let divider = DividerCell()
            divider.message = "Or choose an exisiting category"
            cell = divider
        } else {
            let categoryCell = CreateCategoryCell()
            let category = categories[indexPath.row - 2]
            categoryCell.cardCountLabel.text = "\(category.cardCount) cards"
            categoryCell.nameLabel.text = category.name
            cell = categoryCell
        }
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + categories.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 80.0
        } else if (indexPath.row == 1) {
            return 50.0
        } else {
            return 100.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            handleCreateCategory()
        } else if indexPath.row > 1 {
            delegate?.categoryDidChange(title: categories[indexPath.row - 2].name)
            handleDimiss()
        }
    }
    
    fileprivate func handleCreateCategory() {
        // TODO: Implement
    }
    
    @objc fileprivate func handleDimiss() {
        dismiss(animated: true)
    }
}
