//
//  DividerView.swift
//  Essence
//
//  Created by Cole Riggle on 11/24/20.
//

import UIKit

class DividerCell: EssenceCell {
    
    var message: String? {
        didSet {
            messageLabel.text = message
        }
    }
    
    fileprivate let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "center text"
        label.font = .systemFont(ofSize: 13)
        label.textColor = UIColor.Application.Divider.color
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .clear
        
        let bar1 = createBar()
        let bar2 = createBar()
        
        contentView.addSubview(bar1)
        contentView.addSubview(bar2)
        contentView.addSubview(messageLabel)
       
        bar1.translatesAutoresizingMaskIntoConstraints = false
        bar2.translatesAutoresizingMaskIntoConstraints = false
        bar1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        bar2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        bar1.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        bar2.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        bar1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        bar1.trailingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -12).isActive = true
        
        bar2.leadingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 12).isActive = true
        bar2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        
    }
    
    fileprivate func createBar() -> UIView {
        let bar = UIView()
        bar.backgroundColor = UIColor.Application.Divider.color
        return bar
    }
    
}
