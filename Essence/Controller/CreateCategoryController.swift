//
//  CreateCategoryController.swift
//  Essence
//
//  Created by Cole Riggle on 11/26/20.
//

import UIKit

class CreateCategoryController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    fileprivate let categoryInput: EssenceInputView = {
        let view = EssenceInputView()
        view.title = "Category"
        view.placeholder = "Spanish"
        return view
    }()
    
    fileprivate let titleInput: EssenceInputView = {
        let view = EssenceInputView()
        view.title = "Note title"
        view.placeholder = "Top 50 Verbs"
        return view
    }()
    
    fileprivate let locationInput: EssenceInputView = {
        let view = EssenceInputView()
        view.title = "Location"
        view.placeholder = "Notability"
        return view
    }()
    
    fileprivate let createButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Create", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        button.layer.cornerRadius = 25
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
    }
    
}
