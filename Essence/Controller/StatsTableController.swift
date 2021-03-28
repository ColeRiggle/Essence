//
//  StatsTableController.swift
//  Essence
//
//  Created by Cole Riggle on 3/13/21.
//

import UIKit

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .darkContent
    }
}

class StatsTableController: UITableViewController {
    
    // what types of stats?
    // total categories
    // total reviews
    // oldest review
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.barTintColor = .black
        tableView.backgroundColor = UIColor.Application.General.viewBackground
        configureNavigation()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    fileprivate func configureNavigation() {
        self.navigationItem.title = "Stats"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EssenceCell()
        cell.backgroundColor = .black
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
