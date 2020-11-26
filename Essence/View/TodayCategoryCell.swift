//
//  TodayCategoryCell.swift
//  Essence
//
//  Created by Cole Riggle on 11/24/20.
//

import UIKit

class TodayCategoryCell: EssenceCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "EECS 281"
        label.font = .systemFont(ofSize: 48)
        label.textAlignment = .left
        label.textColor = UIColor.Application.General.primaryText
        return label
    }()
    
    let lastStudiedLabel: UILabel = {
        let label = UILabel()
        label.text = "Last studied 4 days ago"
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .left
        label.textColor = UIColor.Application.General.secondaryText
        return label
    }()
    
    let reviewCountLabel: UILabel = {
        let label = UILabel()
        label.text = "6"
        label.font = .systemFont(ofSize: 56)
        label.textAlignment = .left
        label.textColor = .systemRed
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = UIColor.Application.General.foreground
        
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            lastStudiedLabel
        ])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 6
        
        contentView.addSubview(stackView)
        stackView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: nil, padding: .init(top: 8, left: 12, bottom: 6, right: 0))
        
        contentView.addSubview(reviewCountLabel)
        reviewCountLabel.anchor(top: contentView.topAnchor, leading: nil, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 12))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
