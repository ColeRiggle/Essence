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
    
    let completeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "completeReview").withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGreen
        return imageView
    }()
    
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
        stackView.spacing = 8
        
        
        contentView.addSubview(stackView)
        stackView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 6, left: 12, bottom: 6, right: 70))
        
        contentView.addSubview(completeImageView)
        completeImageView.anchor(top: contentView.topAnchor, leading: stackView.trailingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 14, left: 0, bottom: 14, right: 10))
        
        completeImageView.heightAnchor.constraint(equalTo: completeImageView.widthAnchor).isActive = true
    }
}
