//
//  ReviewCell.swift
//  Essence
//
//  Created by Cole Riggle on 1/12/21.
//

import UIKit

class ReviewCell: EssenceCell {
    
    var note: Note? {
        didSet {
            titleLabel.text = note?.title
            locationLabel.text = note?.location
        }
    }
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Note title"
        label.font = .systemFont(ofSize: 26, weight: .medium)
        label.textColor = UIColor.Application.General.primaryText
        return label
    }()
    
    fileprivate let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Notability"
        label.font = .systemFont(ofSize: 18)
        label.textColor = UIColor.Application.General.secondaryText
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, locationLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        
        
        contentView.addSubview(stackView)
        stackView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 6, left: 12, bottom: 6, right: 50))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
