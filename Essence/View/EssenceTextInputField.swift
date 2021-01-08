//
//  EssenceInputView.swift
//  Essence
//
//  Created by Cole Riggle on 11/26/20.
//

import UIKit

protocol EssenceInputFieldDelegate {
    func textFieldClicked(inputField: EssenceTextInputField, textField: UITextField)
    func textEditied(inputField: EssenceTextInputField, textField: UITextField)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
}

class EssenceTextInputField: UIView, UITextFieldDelegate {
    
    var delegate: EssenceInputFieldDelegate?
    
    var title: String? {
        set {
            titleLabel.text = newValue;
        }
        get {
            return titleLabel.text
        }
    }
    
    var placeholder: String? {
        set {
            textField.attributedPlaceholder = NSAttributedString(string: newValue!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.Application.General.secondaryText])
        }
        get {
            return textField.placeholder
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
        
        textField.delegate = self
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: Formatting.sideInset, bottom: 0, right: Formatting.sideInset))
        
        textField.addTarget(self, action: #selector(textFieldClicked), for: .touchDown);
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChange),
            name: UITextField.textDidChangeNotification,
            object: nil)
    }
    
    @objc fileprivate func textDidChange() {
        delegate?.textEditied(inputField: self, textField: textField)
    }
    

    @objc fileprivate func textFieldClicked() {
        delegate?.textFieldClicked(inputField: self, textField: textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return delegate?.textFieldShouldReturn(textField) ?? false
    }
    
    func reset() {
        textField.text = ""
    }
}
