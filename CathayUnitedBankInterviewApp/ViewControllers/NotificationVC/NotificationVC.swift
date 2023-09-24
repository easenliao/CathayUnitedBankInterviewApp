//
//  NotificationVC.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/23.
//
//

import UIKit

// MARK: - NotificationVC

class NotificationVC: UIViewController {
    // MARK: - Public Properties

    // MARK: - Private Properties

    @IBOutlet private var tableView: UITableView!
    private var dataSource: [NotificationModel]

    private let cellConstant = "NotificationTableViewCell"

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    init(dataSource: [NotificationModel]) {
        self.dataSource = dataSource
        super.init(nibName: "NotificationVC", bundle: nil)
        title = "Notification"
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Init

extension NotificationVC {
    func commonInit() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellConstant, bundle: nil), forCellReuseIdentifier: cellConstant)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        let backImage = UIImage(named: "iconArrowWTailBack")
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension NotificationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellConstant, for: indexPath) as? NotificationTableViewCell else {
            return UITableViewCell()
        }
        cell.setItem(item: dataSource[indexPath.row])
        return cell
    }
}
