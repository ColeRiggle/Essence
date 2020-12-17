//
//  CreateCategoryCell.swift
//  Essence
//
//  Created by Cole Riggle on 11/26/20.
//

import UIKit

class CreateCategoryCell: EssenceCell {
    
    fileprivate let maxSize: CGFloat = 32
    fileprivate let minSize: CGFloat = 18
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
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
    
    var cardCount: Int? {
        didSet {
            var newText = String(cardCount ?? 0) + " "
            if (cardCount == 1) {
                newText += " card"
            } else {
                newText += " cards"
            }
            cardCountLabel.text = newText
        }
    }
    
    fileprivate let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Category label"
        label.font = .systemFont(ofSize: 36)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = UIColor.Application.General.primaryText
        return label
    }()
    
    fileprivate let cardCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0 cards"
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .left
        label.textColor = UIColor.Application.General.secondaryText
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            cardCountLabel
        ])
        
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        stackView.spacing = 5
    
        contentView.addSubview(stackView)
        stackView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 6, left: 12, bottom: 6, right: 0))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        contentView.backgroundColor = UIColor.Application.General.foreground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
