//
//  CreateNewCategoryCell.swift
//  Essence
//
//  Created by Cole Riggle on 11/26/20.
//

import UIKit

class CreateNewCategoryCell: EssenceCell {
    
    fileprivate let createLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Application.General.primaryText
        label.text = "Create Category"
        label.font = .systemFont(ofSize: 40)
        return label
    }()
    
    fileprivate let createIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "essence").withRenderingMode(.alwaysOriginal).withTintColor(.systemRed)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let stackView = UIStackView(arrangedSubviews: [
            createIcon,
            createLabel
        ])
        
        stackView.axis = .horizontal
        stackView.spacing = 24
        stackView.distribution = .fillProportionally
        
        contentView.addSubview(stackView)
        
        createIcon.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8).isActive = true
        
        stackView.anchor(top: nil, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 18, bottom: 0, right: 0))
        stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
