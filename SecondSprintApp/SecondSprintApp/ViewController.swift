//
//  ViewController.swift
//  SecondSprintApp
//
//  Created by Svetlana Timofeeva on 08/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .gray
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 220, height: 100))
        label.center = view.center
        label.text = "Welcome, this is gray team"
        
        view.addSubview(label)
    }


}

