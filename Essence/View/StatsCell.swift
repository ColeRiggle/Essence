//
//  StatsCell.swift
//  Essence
//
//  Created by Cole Riggle on 3/31/21.
//

import UIKit

class StatsCell: EssenceCell {
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    var progress: String? {
        didSet {
            progressLabel.text = progress
        }
    }
    
    fileprivate let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .medium)
        label.textColor = UIColor.Application.General.primaryText
        return label
    }()
    
    fileprivate let progressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40)
        label.textColor = UIColor.systemBlue
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, progressLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 20
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 25, bottom: 0, right: 30))
    }
}
