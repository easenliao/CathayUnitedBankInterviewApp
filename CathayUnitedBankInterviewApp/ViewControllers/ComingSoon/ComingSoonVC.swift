//
//  ComingSoonVC.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/24.
//
//

import UIKit

// MARK: - ComingSoonVC

class ComingSoonVC: UIViewController {
    // MARK: - Public Properties

    // MARK: - Private Properties

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        super.loadView()
        Bundle(for: ComingSoonVC.self).loadNibNamed("\(ComingSoonVC.self)", owner: self, options: nil)
    }
}
