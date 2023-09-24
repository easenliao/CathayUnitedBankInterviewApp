//
//  HomeTopViewTableViewCell.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/21.
//

import UIKit

// MARK: - HomeTopTableViewCellDelegate

protocol HomeTopTableViewCellDelegate: AnyObject {
    func navgationToNotificationVC(cell: HomeTopTableViewCell, notificationModels: [NotificationModel])
}

// MARK: - HomeTopTableViewCell

class HomeTopTableViewCell: UITableViewCell {
    // MARK: - Public Properties

    // MARK: - Private  Properties

    @IBOutlet private var bellImageView: UIImageView!
    private var dataSource: [NotificationModel] = []
    private weak var delegate: HomeTopTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func bellAction(_ sender: Any) {
        delegate?.navgationToNotificationVC(cell: self, notificationModels: dataSource)
    }

    override func prepareForReuse() {
        delegate = nil
    }
}

// MARK: ConfigurableCell

extension HomeTopTableViewCell: ConfigurableCell {
    func configure(with model: HomeViewModel.MyAcconutViewType) {
        guard case let .accountTop(dataList) = model else {
            return
        }
        dataSource = dataList
        bellImageView.image = UIImage(named: dataList.isEmpty ? "iconBell01Nomal" : "iconBell02Active")
    }

    func set(delegate: MyAccountTableDelegate) {
        self.delegate = delegate
    }
}
