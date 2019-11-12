//
//  NotesEditorScreenViewController.swift
//  SecondSprintApp
//
//  Created by Svetlana Timofeeva on 09/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

class NotesEditorScreenViewController: UIViewController {

    let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        let backButton = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(onBackButtonTapped))
        navigationItem.setLeftBarButton(backButton, animated: true)
        
        let saveButton = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(onSaveButtonTapped))
        navigationItem.setRightBarButton(saveButton, animated: true)
        
        textField.layer.cornerRadius = 20
        textField.center = view.center
        textField.textAlignment = .center
        textField.backgroundColor = .lightGray
        view.addSubview(textField)
        
    }
    
    @objc
    func onBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func onSaveButtonTapped() {
        let newNote = textField.text ?? ""
        NoteSingleton.shared.notes.addNote(withText: newNote)
        navigationController?.popViewController(animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
}
