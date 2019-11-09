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
        
        let textField = UITextView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        
        textField.text = """
                            Sorry, this option is unavailable.
                            Use web-page to log in.
                         """
        textField.center = view.center
        view.addSubview(textField)
        
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
        AppDelegate.shared.rootViewController.switchBackToLogInScreen()
    }
}
