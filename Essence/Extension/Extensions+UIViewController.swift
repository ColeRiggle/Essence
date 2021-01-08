//
//  Extensions+UIViewController.swift
//  Essence
//
//  Created by Cole Riggle on 1/7/21.
//

import UIKit

extension UIViewController {
    
    func presentErrorAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
        present(alert, animated: true)
    }
}
