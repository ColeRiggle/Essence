//
//  CreateCategoryCell.swift
//  Essence
//
//  Created by Cole Riggle on 11/26/20.
//

import UIKit

class CreateCategoryCell: EssenceCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "EECS 281"
        label.font = .systemFont(ofSize: 42)
        label.textAlignment = .left
        label.textColor = UIColor.Application.General.primaryText
        return label
    }()
    
    let cardCountLabel: UILabel = {
        let label = UILabel()
        label.text = "22 cards"
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .left
        label.textColor = UIColor.Application.General.secondaryText
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = UIColor.Application.General.foreground
        
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            cardCountLabel
        ])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 6
        
        contentView.addSubview(stackView)
        stackView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: nil, padding: .init(top: 8, left: 12, bottom: 6, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
