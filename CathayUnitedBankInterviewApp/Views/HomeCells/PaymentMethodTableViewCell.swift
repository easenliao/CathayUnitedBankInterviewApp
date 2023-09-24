//
//  PaymentMethodTableViewCell.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/21.
//

import UIKit

// MARK: - PaymentMethodTableViewCellDelegate

protocol PaymentMethodTableViewCellDelegate: AnyObject {
    func paymentMethodTableViewCell(_ paymentMethodTableViewCell: PaymentMethodTableViewCell, didSelectMethod: PaymentMethod)
}

// MARK: - PaymentMethodTableViewCell

class PaymentMethodTableViewCell: UITableViewCell {
    // MARK: - Public Properties

    weak var delegate: PaymentMethodTableViewCellDelegate?

    // MARK: - Private  Properties

    @IBOutlet private var collectionView: UICollectionView!
    private var dataSource: [PaymentMethod] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
        collectionView.isScrollEnabled = false
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        contentView.frame = bounds
        contentView.layoutIfNeeded()
        return collectionView.contentSize
    }

    override func prepareForReuse() {
        delegate = nil
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension PaymentMethodTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaymentMethodCollectionViewCell", for: indexPath) as? PaymentMethodCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setItem(item: dataSource[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 3
        let height = (96 / 125) * width
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        delegate?.paymentMethodTableViewCell(self, didSelectMethod: dataSource[indexPath.row])
    }
}

private extension PaymentMethodTableViewCell {
    func commonInit() {
        collectionView.register(UINib(nibName: "PaymentMethodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PaymentMethodCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: ConfigurableCell

extension PaymentMethodTableViewCell: ConfigurableCell {
    func configure(with model: HomeViewModel.MyAcconutViewType) {
        guard case let .paymentMethod(dataList) = model else {
            return
        }
        dataSource = dataList
    }

    func set(delegate: MyAccountTableDelegate) {
        self.delegate = delegate
    }
}
