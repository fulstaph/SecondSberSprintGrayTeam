//
//  NotesEditorScreenViewController.swift
//  SecondSprintApp
//
//  Created by Svetlana Timofeeva on 09/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

class NotesEditorScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        // Do any additional setup after loading the view.
        let backButton = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(onBackButtonTapped))
        navigationItem.setLeftBarButton(backButton, animated: true)
        
        let saveButton = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(onSaveButtonTapped))
        navigationItem.setRightBarButton(saveButton, animated: true)
        
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        textField.center = view.center
        textField.backgroundColor = .gray
        view.addSubview(textField)
    }
    
    @objc
    func onBackButtonTapped() {
        AppDelegate.shared.rootViewController.switchToTaskScreen()
    }
    
    @objc
    func onSaveButtonTapped() {
        noteNum += 1
        AppDelegate.shared.rootViewController.switchToTaskScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
}
