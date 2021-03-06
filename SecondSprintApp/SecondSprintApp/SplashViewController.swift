//
//  SplashViewController.swift
//  SecondSprintApp
//
//  Created by Svetlana Timofeeva on 08/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    let startButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // if we're here it means we're not logged in
        
        // start button set-up
        
        startButton.center = view.center
        startButton.layer.cornerRadius = 20
        startButton.setTitle("Start!", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = .blue
        
        
        startButton.addTarget(self, action: #selector(onStartButtonTapped), for: .touchUpInside)
        view.addSubview(startButton)
        
        // welcome label set-up
        
        let welcomeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        welcomeLabel.center = CGPoint(x: view.center.x, y: view.center.y - 300)
        welcomeLabel.text = "Welcome!"
        welcomeLabel.font = .systemFont(ofSize: 27)
        welcomeLabel.textAlignment = .center
        view.addSubview(welcomeLabel)
        
    }
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startButton.tappped()
    }
    
    @objc
    func onStartButtonTapped() {
        let loggedIn = UserDefaults.standard.bool(forKey: "LOGGED_IN")
        let rootVC = AppDelegate.shared.rootViewController
        if loggedIn {
            rootVC.showTaskScreen()
            self.navigationController?.pushViewController(TasksScreenViewController(), animated: true)
        } else {
            rootVC.showLogInScreen()
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

extension UIButton {
    func tappped() {
        let tap = CASpringAnimation(keyPath: "transform.scale")
        
        tap.fromValue = 0.87
        tap.toValue = 1.0
        tap.autoreverses = true
        tap.repeatCount = HUGE
        tap.initialVelocity = 0.01
        tap.speed = 0.5
        
        layer.add(tap,forKey: nil)
    }
}
