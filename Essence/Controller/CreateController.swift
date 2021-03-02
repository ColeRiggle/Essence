//
//  CreateCategoryController.swift
//  Essence
//
//  Created by Cole Riggle on 11/26/20.
//

import UIKit
import CoreData

class CreateController: UIViewController, EssenceInputFieldDelegate, CreateCategoryDelegate, UITextFieldDelegate {
    
    fileprivate var canCreate = false {
        didSet {
            if canCreate {
                createButton.backgroundColor = .systemBlue
                createButton.isEnabled = true
            } else {
                createButton.backgroundColor = .systemGray3
                createButton.isEnabled = false
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
        view.title = "Note Title"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        categoryInput.delegate = self
        titleInput.delegate = self
        locationInput.delegate = self
        
        print("Setting target")
        createButton.addTarget(self, action: #selector(CreateController.handleCreate), for: .touchUpInside)
    }
    
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
    
    // MARK: EssenceTextInputFieldDelegate functions
    
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("here")
        self.view.endEditing(true)
        return false
    }
    
    // MARK: Other targets / delegate functions
    
    func categoryDidChange(title: String) {
        categoryInput.textField.text = title
    }
    
    @objc func handleCreate() {
        let managedContext = SceneDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
        fetchRequest.includesSubentities = false
        fetchRequest.predicate = NSPredicate(format: "name = %@", categoryInput.textField.text!)
        
        var category: Category?
        
        do {
            let categories = try managedContext.fetch(fetchRequest)
            if categories.count != 1 {
                throw EssenceError("Category not found")
            }
            category = categories.first
            
        } catch {
            print("Error encountered when attempting card creation: \(error)")
            return
        }
        
        createNote(category: category!, noteTitle: titleInput.textField.text!, location: locationInput.textField.text!)
        refreshView()
    }
    
    fileprivate func createNote(category: Category, noteTitle: String, location: String) {
        let managedContext = SceneDelegate.persistentContainer.viewContext
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: managedContext) as! Note
 
        note.setValue(noteTitle, forKey: "title")
        note.setValue(location, forKey: "location")
        note.setValue(0, forKey: "masteryLevel")
        note.setValue(Date(), forKey: "dueDate")
        note.setValue(Date(), forKey: "createdDate")
        note.setValue(Date(), forKey: "lastReviewedDate")
        note.setValue(category, forKey: "category")
        note.setValue(1, forKey: "previousInterval")
        
        do {
            try managedContext.save()
        } catch {
            print("Error encountered when creating note: \(error)")
        }
        
    }
    
    fileprivate func refreshView() {
        categoryInput.reset()
        titleInput.reset()
        locationInput.reset()
        canCreate = false
        self.view.endEditing(true)
    }
}
