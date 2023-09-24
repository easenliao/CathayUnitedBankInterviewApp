//
//  BannerCollectionViewCell.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/22.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        imageView.image = nil
    }

    func setItem(item: BannerModel) {
        guard let url = URL(string: item.linkUrl) else { return }

        ImageManager.shared.fetchImage(url: url) { uiImage in
            DispatchQueue.main.async {
                self.imageView.image = uiImage
            }
        }
    }
}
