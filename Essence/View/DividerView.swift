//
//  DividerView.swift
//  Essence
//
//  Created by Cole Riggle on 11/24/20.
//

import UIKit

class DividerView: UIView {
    
    var text: String? {
        didSet {
            textLabel.text = text
        }
    }
    
    fileprivate let textLabel: UILabel = {
        let label = UILabel()
        label.text = "center text"
        label.textColor = UIColor.Application.Divider.color
        return label
    }()
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        createBar(),
        textLabel,
        createBar()
    ])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillEqually
    }
    
    override func layoutSubviews() {
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        textLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func createBar() -> UIView {
        let bar = UIView()
        bar.backgroundColor = UIColor.Application.Divider.color
        bar.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return bar
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
