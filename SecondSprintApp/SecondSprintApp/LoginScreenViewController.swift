//
//  LoginScreenViewController.swift
//  SecondSprintApp
//
//  Created by Svetlana Timofeeva on 09/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

class LoginScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        let (x, y) = (view.center.x, view.center.y)
        
        
        let image = UIImage(named: "pikapika")
        let pikaImageView = UIImageView(image: image)
        pikaImageView.center = CGPoint(x: x, y: y - 203)
        view.addSubview(pikaImageView)
        
        let signInButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        signInButton.center = CGPoint(x: x, y: y + 50)
        signInButton.layer.cornerRadius = 20
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.backgroundColor = .blue
        signInButton.addTarget(self, action: #selector(onSignInButtonTapped), for: .touchUpInside)
        view.addSubview(signInButton)
        
        let signUpButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        
        signUpButton.center = CGPoint(x: x, y: y + 120)
        signUpButton.layer.cornerRadius = 20
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = .blue
        signUpButton.addTarget(self, action: #selector(onSignUpButtonTapped), for: .touchUpInside)
        view.addSubview(signUpButton)
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
    func onSignInButtonTapped() {
        navigationController?.pushViewController(SignInScreenViewController(), animated: true)
    }
    
    @objc
    func onSignUpButtonTapped() {
        navigationController?.pushViewController(SignUpScreenViewController(), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        navigationController?.isNavigationBarHidden = true
//    }
}
