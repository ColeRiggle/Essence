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
    
    fileprivate let maxSize: CGFloat = 32
    fileprivate let minSize: CGFloat = 18
    
    var name: String? {
        didSet {
            nameLabel.text = name ?? ""
            
            let sizePerCharacter: CGFloat = contentView.frame.width / CGFloat(name?.count ?? 1)

            var fontSize: CGFloat = sizePerCharacter * 1.5

            if (fontSize < minSize) {
                fontSize = minSize
            } else {
                fontSize = maxSize
            }
            nameLabel.text = name
            nameLabel.font = nameLabel.font.withSize(fontSize)
        }
    }
    
    var lastStudied: Date? {
        didSet {
            if let lastStudied = lastStudied {
                let diffComponents = Calendar.current.dateComponents([.hour], from: lastStudied, to: Date())
                let days = diffComponents.day!
                let dayLabel = days == 1 ? "day" : "days"
                lastStudiedLabel.text = "Last studied \(days) \(dayLabel) ago"
            }
           
        }
    }
    
    var reviewCount: Int? {
        didSet {
            reviewCountLabel.text = String(reviewCount!)
        }
    }
    
    fileprivate let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "EECS 281"
        label.font = .systemFont(ofSize: 42)
        label.textAlignment = .left
        label.textColor = UIColor.Application.General.primaryText
        return label
    }()
    
    fileprivate let lastStudiedLabel: UILabel = {
        let label = UILabel()
        label.text = "Last studied 4 days ago"
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .left
        label.textColor = UIColor.Application.General.secondaryText
        return label
    }()
    
    fileprivate let reviewCountLabel: UILabel = {
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
