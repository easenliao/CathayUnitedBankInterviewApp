//
//  ShimmerView.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/21.
//

import UIKit

class ShimmerView: UIView {
    func addGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()

        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [#colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1).cgColor, #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1).cgColor, #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1).cgColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        layer.addSublayer(gradientLayer)

        return gradientLayer
    }

    func addAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 0.9
        return animation
    }

    func startAnimating() {
        let gradientLayer = addGradientLayer()
        let animation = addAnimation()

        gradientLayer.add(animation, forKey: animation.keyPath)
    }
}
