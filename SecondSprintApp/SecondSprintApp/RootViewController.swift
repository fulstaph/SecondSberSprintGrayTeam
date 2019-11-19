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
        let new = UINavigationController(rootViewController: LoginScreenViewController())
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = new
    }
    
    func showTaskScreen() {
        let navigatorController = UINavigationController(rootViewController: LoginScreenViewController())
        let flowLayout = UICollectionViewFlowLayout()
        let mainVC = TasksScreenViewController(collectionViewLayout: flowLayout)
        let settingVC = SettingsScreenViewController()
        let notesVc = NotesScreenViewController()
        let tapBarController = UITabBarController()
        
        tapBarController.viewControllers = [mainVC, notesVc, settingVC]
        mainVC.modalTransitionStyle = .flipHorizontal
        navigatorController.viewControllers = [tapBarController]
        
        addChild(navigatorController)
        navigatorController.view.frame = view.bounds
        view.addSubview(navigatorController.view)
        navigatorController.didMove(toParent: self)
        navigatorController.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = navigatorController
    }
    
}
