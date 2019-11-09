//
//  SignUpScreenViewController.swift
//  SecondSprintApp
//
//  Created by Svetlana Timofeeva on 09/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

class SignInScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sign In"
        
        view.backgroundColor = .white
        
        let backButton = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(logout))
        
        let (x, y) = (view.center.x, view.center.y)
        
        let logInButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        logInButton.center = CGPoint(x: x, y: y)
        logInButton.layer.cornerRadius = 20
        logInButton.setTitle("Press the button", for: .normal)
        logInButton.setTitleColor(.black, for: .normal)
        logInButton.backgroundColor = .blue
        logInButton.addTarget(self, action: #selector(onLogInButtonPressed), for: .touchUpInside)
        view.addSubview(logInButton)
        navigationItem.setLeftBarButton(backButton, animated: true)
        navigationItem.title = "Check-in"
        // Do any additional setup after loading the view.
    }
    
    
    @objc
    func onLogInButtonPressed() {
        // to do
        UserDefaults.standard.set(true, forKey: "LOGGED_IN")
        AppDelegate.shared.rootViewController.showTaskScreen()
    }
    
    
    @objc
    func logout() {
        navigationController?.popViewController(animated: true)
    }
    /*
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
}
