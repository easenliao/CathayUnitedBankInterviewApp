//
//  NotificationVC.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/23.
//
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    // MARK: - Private  Properties

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var statusView: UIView!
    @IBOutlet private var updateDateTimeLabel: UILabel!
    @IBOutlet private var messageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        statusView.clipsToBounds = true
        statusView.layer.cornerRadius = statusView.bounds.width / 2
    }

    func setItem(item: NotificationModel) {
        titleLabel.text = item.title
        statusView.isHidden = item.status
        updateDateTimeLabel.text = item.updateDateTime
        messageLabel.text = item.message
    }
}
