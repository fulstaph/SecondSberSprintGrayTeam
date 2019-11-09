//
//  ViewController.swift
//  SecondSprintApp
//
//  Created by Svetlana Timofeeva on 08/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    private var current: UIViewController
    
    init() {
        self.current = SplashViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        view.backgroundColor = .gray
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 220, height: 100))
//        label.center = view.center
//        label.text = "Welcome, this is gray team"
//
//        view.addSubview(label)
        
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }

    func showLogInScreen() {
        let navigationController = UINavigationController(rootViewController: LoginScreenViewController())
        navigationController.isNavigationBarHidden = true
        addChild(navigationController)
        navigationController.view.bounds = view.bounds
        view.addSubview(navigationController.view)
        navigationController.didMove(toParent: self)
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = navigationController
    }
    
    func showTasksScreen() {
        let navigationController = UINavigationController(rootViewController: TasksScreenViewController())
        navigationController.isNavigationBarHidden = true
        //navigationController.pushViewController(SignUpScreenViewController(), animated: true)
        addChild(navigationController)
        navigationController.view.bounds = view.bounds
        view.addSubview(navigationController.view)
        navigationController.didMove(toParent: self)
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = navigationController
        
    }
    
    func showSignInScreen() {
        let signInVC = SignInScreenViewController()
        let signIn = UINavigationController(rootViewController: signInVC)
        animateFadeTransition(to: signIn)
    }
    
    func showSignUpScreen() {
        let signUpVC = SignUpScreenViewController()
        let signUp = UINavigationController(rootViewController: signUpVC)
        animateFadeTransition(to: signUp)
    }
    
    func switchBackToLogInScreen() {
        let loginViewController = LoginScreenViewController()
        let logoutScreen = UINavigationController(rootViewController: loginViewController)
        animateDismissTransition(to: logoutScreen)
    }
    
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        
        transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()  //1
        }
    }
    
    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        new.view.frame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        current.willMove(toParent: nil)
        addChild(new)
        transition(from: current, to: new, duration: 0.3, options: [], animations: {
            new.view.frame = self.view.bounds
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
}

