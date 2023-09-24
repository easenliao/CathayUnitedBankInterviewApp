//
//  BannerEmptyTableViewCell.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/21.
//

import UIKit

// MARK: - BannerEmptyTableViewCell

class BannerEmptyTableViewCell: UITableViewCell {
    // MARK: - Private  Properties

    @IBOutlet private var adBackgroundView: UIView!
    @IBOutlet private var adView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
}

// MARK: ConfigurableCell

extension BannerEmptyTableViewCell: ConfigurableCell {
    func configure(with model: HomeViewModel.MyAcconutViewType) {}
}

// MARK: - Private Methods

private extension BannerEmptyTableViewCell {
    func commonInit() {
        adBackgroundView.setRoundCorner(radius: 12, color: UIColor.white.cgColor)
        adView.setRoundCorner(radius: 6, color: UIColor.white.cgColor)
    }
}
