//
//  PaymentMethodCollectionViewCell.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/21.
//

import UIKit

class PaymentMethodCollectionViewCell: UICollectionViewCell {
    // MARK: IBOutlets

    @IBOutlet var paymentImageView: UIImageView!
    @IBOutlet var paymentTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setItem(item: PaymentMethod) {
        paymentImageView.image = UIImage(named: item.imageName)
        paymentTitleLabel.text = item.imageTitle
    }
}
