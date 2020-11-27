//
//  TodayTableController.swift
//  Essence
//
//  Created by Cole Riggle on 11/24/20.
//

import UIKit

class TodayTableController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.Application.General.viewBackground
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.alwaysBounceVertical = false
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: EssenceCell
        
        if indexPath.row == 0 {
            cell = TodayCreateCategoryCell()
        } else if indexPath.row == 1 {
            let divider = DividerCell()
            divider.backgroundColor = .clear
            divider.message = "Or select a category"
            cell = divider
        } else {
            cell = TodayCategoryCell()
        }

        cell.backgroundColor = .clear // Needed when insetting the cell's frame in layoutSubviews()
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 180.0
        } else if (indexPath.row == 1) {
            return 50.0
        } else {
            return 100.0
        }
    }
}
