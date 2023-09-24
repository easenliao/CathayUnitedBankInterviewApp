//
//  BannerTableViewCell.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/21.
//

import UIKit

// MARK: - BannerTableViewCellDelegate

protocol BannerTableViewCellDelegate: AnyObject {
    func bannerTableViewCell(_ cell: BannerTableViewCell, selectBanner: BannerModel)
}

// MARK: - BannerTableViewCell

class BannerTableViewCell: UITableViewCell {
    // MARK: - Private  Properties

    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var pageControl: UIPageControl!
    private var dataSource: [BannerModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    private weak var delegate: BannerTableViewCellDelegate?
    private var timer: Timer?

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    override func prepareForReuse() {
        stopTimer()
    }
}

// MARK: - 自動輪播相關

extension BannerTableViewCell {
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    @objc func autoScroll() {
        let currentIndex = Int(collectionView.contentOffset.x / collectionView.frame.width)
        let nextIndex = (currentIndex + 1) % dataSource.count
        collectionView.scrollToItem(at: IndexPath(item: nextIndex, section: 0), at: .right, animated: true)
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension BannerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as? BannerCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setItem(item: dataSource[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.bounds.size
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.bannerTableViewCell(self, selectBanner: dataSource[indexPath.row])
    }
}

// MARK: - ScrollViewDelegate

extension BannerTableViewCell {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = currentPage
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
}

// MARK: ConfigurableCell

extension BannerTableViewCell: ConfigurableCell {
    func configure(with model: HomeViewModel.MyAcconutViewType) {
        guard case let .bannerList(dataList) = model else {
            return
        }
        setData(dataList)
    }

    func set(delegate: MyAccountTableDelegate) {
        self.delegate = delegate
    }
}

// MARK: - Private Methods

private extension BannerTableViewCell {
    func commonInit() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerCollectionViewCell")
    }

    func setData(_ dataList: [BannerModel]) {
        dataSource = dataList
        startTimer()
    }
}
