//
//  NotesEditorScreenViewController.swift
//  SecondSprintApp
//
//  Created by Svetlana Timofeeva on 09/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

class NotesEditorScreenViewController: UIViewController {
    let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        indicator.backgroundColor = .lightGray
        indicator.layer.cornerRadius = 3
        indicator.style = .white
        indicator.color = .white
        return indicator
    }()
    
    let imageButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .white
        button.setTitle("+Добавить картинку", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.clipsToBounds = true
        return button
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 20
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        textField.backgroundColor = .white
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let safeArea = view.safeAreaLayoutGuide
        
        // Do any additional setup after loading the view.
        let backButton = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(onBackButtonTapped))
        navigationItem.setLeftBarButton(backButton, animated: true)
        
        let saveButton = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(onSaveButtonTapped))
        navigationItem.setRightBarButton(saveButton, animated: true)
        textField.center = view.center
        view.addSubview(imageButton)
        view.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        
        imageButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50).isActive = true
        imageButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -50).isActive = true
        imageButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 50).isActive = true
        imageButton.heightAnchor.constraint(equalTo: imageButton.widthAnchor, multiplier: 1).isActive = true
        
        textField.topAnchor.constraint(equalTo: imageButton.bottomAnchor, constant: 20).isActive = true
        textField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -50).isActive = true
        textField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 50).isActive = true
        textField.bottomAnchor.constraint(greaterThanOrEqualTo: safeArea.bottomAnchor, constant: -50).isActive = true
        textField.heightAnchor.constraint(equalTo: textField.widthAnchor, multiplier: 1).isActive = true

        imageButton.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
    }
    
    @objc
    func showPicker() {
        view.addSubview(loadingIndicator)
        loadingIndicator.center = view.center
        loadingIndicator.startAnimating()
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary;
        picker.allowsEditing = false
        self.present(picker, animated: true, completion: nil)
    }
    
    @objc
    func onBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func onSaveButtonTapped() {
        loadingIndicator.startAnimating()
        let newNote = textField.text ?? ""
        guard let newImage = imageButton.imageView!.image else { return }
        NoteSingleton.shared.notes.addNote(withText: newNote, withImage: newImage)
        loadingIndicator.stopAnimating()
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
}

extension NotesEditorScreenViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            let selectedImage: UIImage = image
            imageButton.setImage(selectedImage, for: .normal)
            loadingIndicator.stopAnimating()
            picker.dismiss(animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        loadingIndicator.stopAnimating()
        picker.dismiss(animated: true)
    }
}
