//
//  CreateCategoryController.swift
//  Essence
//
//  Created by Cole Riggle on 11/26/20.
//

import UIKit

class CreateController: UIViewController, EssenceInputFieldDelegate, CreateCategoryDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    fileprivate var canCreate = false {
        didSet {
            if canCreate {
                createButton.backgroundColor = .systemBlue
            } else {
                createButton.backgroundColor = .systemGray3
            }
        }
    }
    
    fileprivate let categoryInput: EssenceTextInputField = {
        let view = EssenceTextInputField()
        view.title = "Category"
        view.placeholder = "Spanish"
        return view
    }()
    
    fileprivate let titleInput: EssenceTextInputField = {
        let view = EssenceTextInputField()
        view.title = "Note title"
        view.placeholder = "Top 50 Verbs"
        return view
    }()
    
    fileprivate let locationInput: EssenceTextInputField = {
        let view = EssenceTextInputField()
        view.title = "Location"
        view.placeholder = "Notability"
        return view
    }()
    
    fileprivate let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        button.layer.cornerRadius = 25
        button.isEnabled = false
        return button
    }()
    
    fileprivate func setupLayout() {
        view.backgroundColor = UIColor.Application.General.viewBackground
        
        let stackView = UIStackView(arrangedSubviews: [
            categoryInput,
            titleInput,
            locationInput
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 12
        
        view.addSubview(stackView)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        
        let sectionHeight: CGFloat = 100
        
        categoryInput.heightAnchor.constraint(equalToConstant: sectionHeight).isActive = true
        titleInput.heightAnchor.constraint(equalToConstant: sectionHeight).isActive = true
        locationInput.heightAnchor.constraint(equalToConstant: sectionHeight).isActive = true
        
        view.addSubview(createButton)
        createButton.anchor(top: stackView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 24, left: 0, bottom: 0, right: 0))
        createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        
        categoryInput.delegate = self
        titleInput.delegate = self
        locationInput.delegate = self
        canCreate = false
    }
    
    func textFieldClicked(inputField: EssenceTextInputField, textField: UITextField) {
        if inputField == categoryInput {
            textField.isEnabled = false
            let selectCategoryController = SelectCategoryTableController()
            selectCategoryController.delegate = self
            let navController = UINavigationController(rootViewController: selectCategoryController)
            present(navController, animated: true)
            textField.isEnabled = true
        }
    }
    
    func textEditied(inputField: EssenceTextInputField, textField: UITextField) {
        if categoryInput.textField.text ?? "" != "" && titleInput.textField.text ?? "" != "" && locationInput.textField.text ?? "" != "" {
            canCreate = true
        } else {
            canCreate = false
        }
        
    }
    
    func categoryDidChange(title: String) {
        categoryInput.textField.text = title
    }
    
}
