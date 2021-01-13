//
//  ReviewTableController.swift
//  Essence
//
//  Created by Cole Riggle on 1/12/21.
//

import UIKit

class ReviewTableController: UITableViewController {
    
    var category: Category? {
        didSet {
            if let category = category {
                navigationItem.title = category.name
                notes = databaseService.getNotesForCategory(category)
            }
            tableView.reloadData()
        }
    }
    
    fileprivate var notes: [Note] = []
    
    fileprivate var databaseService = EssenceDatabaseService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Application.General.viewBackground
        tableView.separatorStyle = .none
        
        navigationController?.navigationBar.barStyle = .black
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(handleBack))
        backButton.tintColor = UIColor.Application.General.navigationTint
        editButton.tintColor = UIColor.Application.General.navigationTint
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = editButton
    }
    
    @objc fileprivate func handleBack() {
        dismiss(animated: true)
    }
    
    @objc fileprivate func handleEdit() {
        dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = EssenceCell()
        
        if indexPath.row == 0 {
            let divider = DividerCell()
            if indexPath.section == 0 {
                divider.message = "Due for review"
            } else if indexPath.section == 1 {
                divider.message = "Due later"
            }
            cell = divider
        } else {
            let reviewCell = ReviewCell()
            reviewCell.note = notes[indexPath.row - 1]
            cell = reviewCell
        }
        
        cell.backgroundColor = UIColor.Application.General.viewBackground
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 30 : 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return notes.count + 1
        } else if section == 1 {
            return 1
        }
        
        return 0
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
}
