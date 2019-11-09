//
//  ViewController.swift
//  UIKitLesson
//
//  Created by Kaplan Deniz on 11/10/2019.
//  Copyright © 2019 DK. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Coordinatable {

	weak var delegate: Coordinator?

    
	override func loadView() {
		let gradientView = GradientView()
		gradientView.colors = [.yellow, .green]
		view = gradientView
	}

	var gradientView: GradientView {
		return view as! GradientView
	}

	let button: UIButton = {
		let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
		button.backgroundColor = .gray
		button.setTitle("Redraw", for: .normal)
		button.layer.cornerRadius = 20
		return button
	}()

    
	let circle: UIView = {
		let view = UIView(frame: CGRect(x: 140, y: 200, width: 100, height: 100))
		view.layer.cornerRadius = 50
        view.backgroundColor = .red
		return view
	}()
    

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .red

		view.addSubview(button)
		view.addSubview(circle)
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(redCircleTapped))
		circle.addGestureRecognizer(tapGesture)
		button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}

	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
    
		button.center = view.center
	}

	private func randomGradientColor() -> [UIColor] {
		return [UIColor.random(), UIColor.random()]
	}

	@objc private func redCircleTapped() {
		delegate?.change(self)
	}
    

	@objc private func buttonTapped() {
		gradientView.colors = randomGradientColor()
	}
}

extension UIColor {

	static func random() -> UIColor {
		let red = CGFloat(Float.random(in: 0...255) / 255)
		let green = CGFloat(Float.random(in: 0...255) / 255)
		let blue = CGFloat(Float.random(in: 0...255) / 255)
		return UIColor(red: red,
					   green: green,
					   blue: blue,
					   alpha: 1)
	}
}

