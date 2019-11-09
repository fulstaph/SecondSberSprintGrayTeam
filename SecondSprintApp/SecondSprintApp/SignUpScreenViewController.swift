//
//  SignUpScreenViewController.swift
//  SecondSprintApp
//
//  Created by Svetlana Timofeeva on 09/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

class SignUpScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        let (x, y) = (view.center.x, view.center.y)
        let textField = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        textField.font = UIFont.systemFont(ofSize: 25.0)
        textField.textAlignment = .center
        textField.text = "Sorry, this option is unavailable."
        textField.lineBreakMode = .byWordWrapping
        textField.numberOfLines = 2
        textField.center = CGPoint(x: x, y: y - 30)
        textField.adjustsFontSizeToFitWidth = true
        view.addSubview(textField)
        
        let textField2 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        textField2.font = UIFont.systemFont(ofSize: 25.0)
        textField2.textAlignment = .center
        textField2.text = "Use webpage to log in."
        textField2.lineBreakMode = .byWordWrapping
        textField2.numberOfLines = 2
        textField2.center = CGPoint(x: x, y: y + 30)
        textField2.adjustsFontSizeToFitWidth = true
        view.addSubview(textField2)
        
        let backButton = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(logout))
        
        navigationItem.setLeftBarButton(backButton, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc
    func logout() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
}
