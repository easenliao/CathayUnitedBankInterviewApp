//
//  FavoriteCollectionViewCell.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/21.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setItem(item: FavoriteModel) {
        iconImageView.image = UIImage(named: item.transType.iconName)
        iconImageView.sizeToFit()
        nicknameLabel.text = item.nickname
    }
}
