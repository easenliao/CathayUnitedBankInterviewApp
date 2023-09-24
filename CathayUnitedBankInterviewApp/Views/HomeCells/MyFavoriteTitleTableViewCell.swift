//
//  MyFavoriteTitleTableViewCell.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/21.
//

import UIKit

// MARK: - MyFavoriteTitleTableViewCell

class MyFavoriteTitleTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: ConfigurableCell

extension MyFavoriteTitleTableViewCell: ConfigurableCell {
    func configure(with model: HomeViewModel.MyAcconutViewType) {}
}
