//
//  BaseTabBarController.swift
//  Essence
//
//  Created by Cole Riggle on 11/24/20.
//

import UIKit
import CoreData

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.tabBar.tintColor = UIColor.Application.General.navigationTint
        self.tabBar.barTintColor = .black
        
        viewControllers = [
            createNavController(viewController: TodayTableController(), title: "Today", image: #imageLiteral(resourceName: "today")),
            createNavController(viewController: CreateController(), title: "Create", image: #imageLiteral(resourceName: "essence")),
            createNavController(viewController: UIViewController(), title: "Stats", image: #imageLiteral(resourceName: "stats"))
        ]
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        viewController.tabBarItem.image = image
        viewController.tabBarItem.title = title
        return viewController
    }
}
