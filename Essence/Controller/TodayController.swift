//
//  HomeViewController.swift
//  Essence
//
//  Created by Cole Riggle on 10/30/20.
//

import UIKit

class TodayController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let table = TodayTableController()
        view.addSubview(table.tableView)
        table.tableView.fillSuperview()
        
    }
    
    
    
}
