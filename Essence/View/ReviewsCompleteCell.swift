//
//  ReviewsCompleteCell.swift
//  Essence
//
//  Created by Cole Riggle on 1/13/21.
//

import UIKit

class ReviewsCompleteCell: EssenceCell {
    
    fileprivate let informationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Application.General.primaryText
        label.text = "All Reviews Complete"
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    fileprivate let completeIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "checkmark").withRenderingMode(.alwaysOriginal).withTintColor(.systemGreen)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        contentView.addSubview(completeIcon)
        contentView.addSubview(informationLabel)
        
        completeIcon.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: nil, padding: .init(top: 8, left: 12, bottom: 8, right: 0))
        completeIcon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        informationLabel.anchor(top: contentView.topAnchor, leading: completeIcon.trailingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 8, left: 12, bottom: 8, right: 12))
        
    }
}
