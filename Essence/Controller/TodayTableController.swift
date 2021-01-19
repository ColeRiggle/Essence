//
//  TodayTableController.swift
//  Essence
//
//  Created by Cole Riggle on 11/24/20.
//

import UIKit
import CoreData

class TodayTableController: BaseCategoryDisplayController {
    
    fileprivate let databaseService = EssenceDatabaseService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.Application.General.viewBackground
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.alwaysBounceVertical = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = EssenceCell()
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let reviewCell = TodayReviewCell()
                reviewCell.notesDue = databaseService.getDueNotes().count
                cell = reviewCell
            } else if indexPath.row == 1 {
                let divider = DividerCell()
                divider.backgroundColor = .clear
                divider.message = "Or select a category"
                cell = divider
            }
        } else {
            let todayCategoryCell = TodayCategoryCell()
            if let category = getCategory(for: indexPath) {
                let notes = databaseService.getNotesForCategory(category)
                
                todayCategoryCell.reviewCount = notes.count
                todayCategoryCell.name = category.name
                todayCategoryCell.lastStudied = category.lastReviewed
            }
            
            cell = todayCategoryCell
        }

        cell.backgroundColor = .clear // Needed when insetting the cell's frame in layoutSubviews()
        cell.selectionStyle = .none // Needed so that color doesn't change when selected
        
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
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                return 180.0
            } else {
                return 50.0
            }
        } else {
            return 100.0
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reviewController = ReviewTableController()
        let navController = UINavigationController(rootViewController: reviewController)
        navController.modalPresentationStyle = .overFullScreen
        reviewController.category = getCategory(for: indexPath)
        present(navController, animated: true)
    }
}
