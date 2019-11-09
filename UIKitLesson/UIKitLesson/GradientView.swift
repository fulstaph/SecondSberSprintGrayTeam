//
//  GradientView.swift
//  UIKitLesson
//
//  Created by Kaplan Deniz on 11/10/2019.
//  Copyright © 2019 DK. All rights reserved.
//

import UIKit

final class GradientView: UIView {

	var colors: [UIColor] = [] {
		didSet {
			update()
		}
	}

	override class var layerClass: AnyClass {
		return CAGradientLayer.self
	}

	var gradientLayer: CAGradientLayer {
		return layer as? CAGradientLayer ?? CAGradientLayer()
	}

	func update() {
		gradientLayer.colors = colors.compactMap { $0.cgColor }
	}
}
