//
//  SettingsScreenViewController.swift
//  SecondSprintApp
//
//  Created by Svetlana Timofeeva on 09/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

class SettingsScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //self.title = "Settings"
        // Do any additional setup after loading the view.
        
        let signOutButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        signOutButton.setTitle("Sign out", for: .normal)
        signOutButton.setTitleColor(.white, for: .normal)
        signOutButton.layer.cornerRadius = 20
        signOutButton.center = view.center
        signOutButton.backgroundColor = .blue
        signOutButton.addTarget(self, action: #selector(signOutOnTapped), for: .touchUpInside)
        view.addSubview(signOutButton)
    }
    

    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "settings"), tag: 3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func signOutOnTapped() {
        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
        AppDelegate.shared.rootViewController.showLogInScreen()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}
