//
//  UIExtension.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/21.
//

import UIKit

extension UIView {
    /// 貼上全滿的 View
    func addFillView(_ view: UIView) {
        backgroundColor = .clear
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    /// loadNib
    @discardableResult
    func loadNibView() -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        guard let contentView = Bundle(for: Self.self).loadNibNamed("\(Self.self)", owner: self, options: nil)?.first as? UIView else {
            fatalError("loadNibNamed failure")
        }
        addFillView(contentView)
        return contentView
    }

    func safetyRemoveFromSuperview() {
        if let _ = superview {
            removeFromSuperview()
        }
    }
}
