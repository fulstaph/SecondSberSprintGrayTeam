//
//  SecondViewController.swift
//  UIKitLesson
//
//  Created by Kaplan Deniz on 11/10/2019.
//  Copyright © 2019 DK. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    public weak var delegate: Coordinator?

    let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        button.backgroundColor = .gray
        button.setTitle("Third VC", for: .normal)
        button.layer.cornerRadius = 20
        return button
    }()
    
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Second VC"
		view.backgroundColor = .white
        
        button.center = view.center
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
	}


    
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.setNavigationBarHidden(false, animated: animated)
	}
    
    @objc private func buttonTapped() {
        let thirdViewController = ThirdViewControler()
        navigationController?.pushViewController(thirdViewController, animated: true)
//        delegate?.change(self)
    }
}
