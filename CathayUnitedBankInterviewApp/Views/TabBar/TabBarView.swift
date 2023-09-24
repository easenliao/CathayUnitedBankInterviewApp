//
//  TabBarView.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/21.
//
//

import UIKit

// MARK: - TabBarViewDelegate

protocol TabBarViewDelegate: AnyObject {
    func tabBarView(_ view: TabBarView, homeAction: Void)
    func tabBarView(_ view: TabBarView, accountAction: Void)
    func tabBarView(_ view: TabBarView, locationAction: Void)
    func tabBarView(_ view: TabBarView, serviceAction: Void)
}

// MARK: - TabBarView

class TabBarView: UIView {
    // MARK: - Public Properties

    weak var delegate: TabBarViewDelegate?

    // MARK: - Private Properties

    @IBOutlet private var contentView: UIView!

    @IBOutlet var shadowView: UIView!

    // MARK: - Lifecycle

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    @IBAction func homeAction(_ sender: Any) {
        delegate?.tabBarView(self, homeAction: ())
    }

    @IBAction func accountAction(_ sender: Any) {
        delegate?.tabBarView(self, accountAction: ())
    }

    @IBAction func locationAction(_ sender: Any) {
        delegate?.tabBarView(self, locationAction: ())
    }

    @IBAction func serviceAction(_ sender: Any) {
        delegate?.tabBarView(self, serviceAction: ())
    }
}

// MARK: - Action

extension TabBarView {}

// MARK: - Private Methods

extension TabBarView {
    func commonInit() {
        setupView()
    }

    func setupView() {
        loadNibView()
        shadowView.setDefaultShadow(cornerRadius: 25)
    }
}
