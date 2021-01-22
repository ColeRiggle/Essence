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
                dueNotes = databaseService.getDueNotesForCategory(category)
                undueNotes = databaseService.getUndueNotesForCategory(category)
            }
            let range = NSMakeRange(0, self.tableView.numberOfSections)
            let sections = NSIndexSet(indexesIn: range)
            self.tableView.reloadSections(sections as IndexSet, with: .automatic)
        }
    }
    
    fileprivate var dueNotes: [Note] = []
    fileprivate var undueNotes: [Note] = []
    
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
    
    fileprivate func getNoteForIndexPath(_ indexPath: IndexPath) -> Note? {
        if indexPath.section == 0 {
            return dueNotes[indexPath.row - 1]
        } else if indexPath.section == 1 {
            return undueNotes[indexPath.row - 1]
        }
        
        return nil
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
            if dueNotes.count == 0 && indexPath.row == 1 && indexPath.section == 0 {
                cell = ReviewsCompleteCell()
            } else {
                let reviewCell = ReviewCell()
                reviewCell.note = getNoteForIndexPath(indexPath)
                if let note = reviewCell.note, let dueDate = note.dueDate {
                    if note.isDue() {
                        reviewCell.completeImageView.isHidden = false
                        if Calendar.current.isDate(dueDate, inSameDayAs: Date()) {
                            reviewCell.completeImageView.tintColor = .systemGreen
                        } else {
                            reviewCell.completeImageView.tintColor = .systemRed
                        }
                    } else {
                        reviewCell.completeImageView.isHidden = true
                    }
                }
                cell = reviewCell
            }
        }
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 30 : 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if dueNotes.count == 0 {
                return 2
            }
            return dueNotes.count + 1
        } else if section == 1 {
            return undueNotes.count + 1
        }
        
        return 0
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row != 0 {
            if dueNotes.count != 0 {
                if let note = getNoteForIndexPath(indexPath) {
                    note.dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
                    databaseService.save()
                    reload()
                }
            }
        }
    }
    
    fileprivate func reload() {
        let cat = category
        category = cat
    }
    
    
    fileprivate func canDelete(forRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 1 && indexPath.row != 0
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
        let confirmationAlert = UIAlertController(title: "Delete Note?", message: "This note will be permanently deleted.", preferredStyle: .alert)
        
        confirmationAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            success(true)
        }))
        
        confirmationAlert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] (_) in
            if let self = self {
                self.tableView(self.tableView, commit: .delete, forRowAt: indexPath)
            }
            success(true)
        }))
        
        self.present(confirmationAlert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let note = getNoteForIndexPath(indexPath) {
                databaseService.deleteNote(note)
                reload()
            }
        }
    }
    
}
