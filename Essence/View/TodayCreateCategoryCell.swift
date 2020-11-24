//
//  TodayCreateCategoryCell.swift
//  Essence
//
//  Created by Cole Riggle on 11/24/20.
//

import UIKit

class TodayCreateCategoryCell: TodayCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    let notesDueLabel: UILabel = {
        let label = UILabel()
        label.text = "7 Notes Due"
        label.font = .systemFont(ofSize: 45)
        label.textAlignment = .center
        label.textColor = UIColor.Application.General.primaryText
        return label
    }()
    
    let reviewAllButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Review All", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.layer.cornerRadius = 30
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let stackView = UIStackView(arrangedSubviews: [notesDueLabel, reviewAllButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        
        
        contentView.addSubview(stackView)
        stackView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 18, left: 24, bottom: 0, right: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
