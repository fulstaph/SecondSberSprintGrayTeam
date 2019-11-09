//
//  SplashViewController.swift
//  SecondSprintApp
//
//  Created by Svetlana Timofeeva on 08/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // if we're here it means we're not logged in
        
        // start button set-up
        let startButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        startButton.center = view.center
        startButton.layer.cornerRadius = 20
        startButton.setTitle("Start!", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.backgroundColor = .blue
        startButton.addTarget(self, action: #selector(onStartButtonTapped), for: .touchUpInside)
        view.addSubview(startButton)
        
        // welcome label set-up
        
        let welcomeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        welcomeLabel.center = CGPoint(x: view.center.x + 52, y: view.center.y - 300.0)
        welcomeLabel.text = "Welcome!"
        welcomeLabel.font = .systemFont(ofSize: 22)
        view.addSubview(welcomeLabel)
        
    }
    
    @objc
    func onStartButtonTapped() {
        let loggedIn = UserDefaults.standard.bool(forKey: "LOGGED_IN")
        if loggedIn {
            AppDelegate.shared.rootViewController.showTasksScreen()
        } else {
            AppDelegate.shared.rootViewController.showLogInScreen()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected  to the new view controller.
    }
    */

}
