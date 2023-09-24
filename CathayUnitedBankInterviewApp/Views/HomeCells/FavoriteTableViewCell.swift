//
//  FavoriteEmptyTableViewCell.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/21.
//

import UIKit

// MARK: - FavoriteTableViewCellDelegate

protocol FavoriteTableViewCellDelegate: AnyObject {
    func favoriteTableViewCell(_ cell: FavoriteTableViewCell, selectFavorite: FavoriteModel)
}

// MARK: - FavoriteTableViewCell

class FavoriteTableViewCell: UITableViewCell {
    // MARK: - Private  Properties

    @IBOutlet private var emptyView: UIView!
    @IBOutlet private var collectionView: UICollectionView!
    private var dataSource: [FavoriteModel] = [] {
        didSet {
            if dataSource.isEmpty {
                emptyView.isHidden = false
                collectionView.isHidden = true
            } else {
                emptyView.isHidden = true
                collectionView.isHidden = false
            }
            collectionView.reloadData()
        }
    }

    private weak var delegate: FavoriteTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    func setData(_ dataList: [FavoriteModel]) {
        dataSource = dataList
    }
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension FavoriteTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as? FavoriteCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setItem(item: dataSource[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = collectionView.bounds.width / 4
        return CGSize(width: length, height: length)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.favoriteTableViewCell(self, selectFavorite: dataSource[indexPath.row])
    }
}

private extension FavoriteTableViewCell {
    func commonInit() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FavoriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FavoriteCollectionViewCell")
    }
}

// MARK: ConfigurableCell

extension FavoriteTableViewCell: ConfigurableCell {
    func configure(with model: HomeViewModel.MyAcconutViewType) {
        guard case let .favoriteList(dataList) = model else {
            return
        }
        dataSource = dataList
    }

    func set(delegate: MyAccountTableDelegate) {
        self.delegate = delegate
    }
}
