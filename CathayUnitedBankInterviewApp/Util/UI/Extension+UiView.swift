//
//  Style.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/21.
//
import UIKit

extension UIView {
    func setDefaultShadow(cornerRadius: CGFloat) {
        layer.masksToBounds = false
        layer.cornerRadius = cornerRadius
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowOpacity = 0.2
    }

    func setRoundCorner(radius: CGFloat, color: CGColor) {
        layer.borderColor = color
        clipsToBounds = true
        layer.cornerRadius = radius
    }
}
