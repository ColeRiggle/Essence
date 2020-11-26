//
//  CreateTableController.swift
//  Essence
//
//  Created by Cole Riggle on 11/26/20.
//

import UIKit

class CreateTableController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.Application.General.viewBackground
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.alwaysBounceVertical = false
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
            
        }
        
        cell.backgroundColor = .clear
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 80.0
        } else if (indexPath.row == 1) {
            return 50.0
        } else {
            return 120.0
        }
    }
}
