//
//  EssenceInputView.swift
//  Essence
//
//  Created by Cole Riggle on 11/26/20.
//

import UIKit

protocol EssenceInputFieldDelegate {
    func textFieldClicked(textField: UITextField)
}

class EssenceTextInputField: UIView {
    
    var delegate: EssenceInputFieldDelegate?
    
    var title: String? {
        didSet {
            titleLabel.text = title;
        }
    }
    
    var placeholder: String? {
        didSet {
            textField.attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.Application.General.secondaryText])
        }
    }
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title label"
        label.textColor = UIColor.Application.General.secondaryText
        label.font = .systemFont(ofSize: 18, weight: .heavy)
        return label
    }()
    
    let textField: InsetTextField = {
        let textField = InsetTextField()
        textField.layer.cornerRadius = 8
        textField.textColor = .white
        textField.backgroundColor = UIColor.Application.General.foreground
        textField.placeholder = "placeholder"
        return textField
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            textField
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: Formatting.sideInset, bottom: 0, right: Formatting.sideInset))
        
        textField.addTarget(self, action: #selector(textFieldClicked), for: .touchDown);
    }
    
    @objc fileprivate func textFieldClicked() {
        delegate?.textFieldClicked(textField: textField)
    }
}
