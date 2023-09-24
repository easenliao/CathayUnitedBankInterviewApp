//
//  ConfigurableCell.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/24.
//

import Foundation
import UIKit

// MARK: - ConfigurableCell

// 用多型解決需要在TableView做switch
protocol ConfigurableCell: UITableViewCell {
    typealias MyAccountTableDelegate =
        HomeTopTableViewCellDelegate&
    PaymentMethodTableViewCellDelegate&
    FavoriteTableViewCellDelegate&
    BannerTableViewCellDelegate

    func configure(with model: HomeViewModel.MyAcconutViewType)
    func set(delegate: MyAccountTableDelegate)
}

extension ConfigurableCell {
    func set(delegate: MyAccountTableDelegate) {}
}
