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
        tableView.register(TodayCreateCategoryCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .clear // Needed when inseting the cell's frame in willLayoutSubviews()
            return cell
        } else if indexPath.row == 1 {
            let cell = UITableViewCell()
            cell.backgroundColor = .clear
            let divider = DividerView()
            cell.addSubview(divider)
            //divider.fillSuperview()
            divider.anchor(top: nil, leading: cell.leadingAnchor, bottom: nil, trailing: cell.trailingAnchor)
            //divider.heightAnchor.constraint(equalToConstant: 50).isActive = true
            divider.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            divider.text = "Or select a category"
            return cell
        }

        return UITableViewCell()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 180.0
        } else {
            return 130.0
        }
    }
    
    
    
}
