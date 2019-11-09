//
//  CoordinatingController.swift
//  UIKitLesson
//
//  Created by Kaplan Deniz on 05/11/2019.
//  Copyright © 2019 DK. All rights reserved.
//

import UIKit

protocol Coordinatable: AnyObject {
	var delegate: Coordinator? { get set }
}

protocol Coordinator: AnyObject {
	func change(_ current: UIViewController)
}

final class CoordinatingController: UIViewController {
	let navController = UINavigationController()

	init(with first: UIViewController) {
		navController.viewControllers = [first]
		super.init(nibName: nil, bundle: nil)
		(first as! Coordinatable).delegate = self
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CoordinatingController: Coordinator {

	func change(_ current: UIViewController) {
		self.navController.pushViewController(resolveDestination(from: current), animated: true)
	}

	private func resolveDestination(from viewController: UIViewController) -> UIViewController {
            return SecondViewController()
	}
    
}
