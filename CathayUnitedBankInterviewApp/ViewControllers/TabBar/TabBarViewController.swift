//
//  UITabBarViewController.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/21.
//

import UIKit

// MARK: - TabBarViewController

class TabBarViewController: UITabBarController {
    let tabBarView = TabBarView()
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

private extension TabBarViewController {
    func commonInit() {
        setupView()
        tabBarView.delegate = self
        let homeVC = HomeVC()
        let accountVC = ComingSoonVC()
        let locationVC = ComingSoonVC()
        let serviceVC = ComingSoonVC()
        viewControllers = [homeVC, accountVC, locationVC, serviceVC]
    }

    func setupView() {
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBarView)

        NSLayoutConstraint.activate([
            tabBarView.heightAnchor.constraint(equalToConstant: 50),
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            tabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
        ])
    }
}

// MARK: TabBarViewDelegate

extension TabBarViewController: TabBarViewDelegate {
    func tabBarView(_ view: TabBarView, homeAction: Void) {
        selectedIndex = 0
    }

    func tabBarView(_ view: TabBarView, accountAction: Void) {
        selectedIndex = 1
    }

    func tabBarView(_ view: TabBarView, locationAction: Void) {
        selectedIndex = 2
    }

    func tabBarView(_ view: TabBarView, serviceAction: Void) {
        selectedIndex = 3
    }
}
