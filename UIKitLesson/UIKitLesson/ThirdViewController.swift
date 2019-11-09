//
//  ThirdViewController.swift
//  UIKitLesson
//
//  Created by Alexander on 08.11.2019.
//  Copyright © 2019 DK. All rights reserved.
//

import UIKit

class ThirdViewControler: UIViewController {
    
    
    let circle: GradientView = {
        let view = GradientView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        view.colors = [.yellow, .red]
        view.layer.cornerRadius = 150
        return view
            }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Third VC"
        view.backgroundColor = .white
        view.addSubview(circle)
        circle.center = view.center
    
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(gradientCircleTapped(sender:)))
        circle.addGestureRecognizer(panGestureRecognizer)
        

        let fromTopToDownSwipe = UISwipeGestureRecognizer(target: self, action: #selector(popVC(sender:)))
        fromTopToDownSwipe.direction = .down
        view.addGestureRecognizer(fromTopToDownSwipe)
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    

    
    
    @objc
    func gradientCircleTapped(sender: UIPanGestureRecognizer) {
        let coordinatesX = (sender.translation(in: circle).x)*2.57
        let coordinatesY = (sender.translation(in: circle).y)*2.57
        let color1 = UIColor(red: CGFloat(coordinatesY/255), green: coordinatesY/255, blue: coordinatesX/255, alpha: 1)
        let color2 = UIColor(red: CGFloat(coordinatesY/255), green: CGFloat(coordinatesX/255), blue: CGFloat(coordinatesX/255), alpha: CGFloat((coordinatesX + coordinatesY)/255 / 2))
        circle.colors = [color1, color2]
    }
    
    @objc
    func popVC(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            navigationController?.popViewController(animated: true)
        }
    }
}
