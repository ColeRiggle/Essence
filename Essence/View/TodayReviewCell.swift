//
//  TodayCreateCategoryCell.swift
//  Essence
//
//  Created by Cole Riggle on 11/24/20.
//

import UIKit

protocol TodayReviewDelegate {
    func handleReviewAll()
}

class TodayReviewCell: EssenceCell {
    
    var todayReviewDelegate: TodayReviewDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    var notesDue: Int = 0 {
        didSet {
            if notesDue == 1 {
                reviewAllButton.backgroundColor = .systemBlue
                notesDueLabel.text = "1 Note Due"
                reviewAllButton.isEnabled = true
            } else if notesDue == 0 {
                reviewAllButton.backgroundColor = .systemGray
                notesDueLabel.text = "No Notes Due"
                reviewAllButton.isEnabled = false
            } else {
                reviewAllButton.backgroundColor = .systemBlue
                notesDueLabel.text = "\(notesDue) Notes Due"
                reviewAllButton.isEnabled = true
            }
        }
    }
    
    fileprivate let notesDueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 45)
        label.textAlignment = .center
        label.textColor = UIColor.Application.General.primaryText
        return label
    }()
    
    fileprivate let reviewAllButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Review All", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.layer.cornerRadius = 30
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return button
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let stackView = UIStackView(arrangedSubviews: [notesDueLabel, reviewAllButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        
        
        contentView.addSubview(stackView)
        stackView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 18, left: 24, bottom: 0, right: 24))
        
        reviewAllButton.addTarget(self, action: #selector(handleReviewAll), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleReviewAll() {
        todayReviewDelegate?.handleReviewAll()
    }
}
