//
//  HomeVC.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/21.
//
//

import UIKit

// MARK: - HomeVC

class HomeVC: UIViewController {
    // MARK: - Public Properties

    // MARK: - Private Properties

    private var refreshControl: UIRefreshControl!
    private var viewModel = HomeViewModel(apiManager: APIManager.shared)
    private var dataSource: [Int: HomeViewModel.MyAcconutViewType] = [:] {
        didSet {
            tableView.reloadData()
        }
    }

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.separatorStyle = .none
        }
    }

    private let emptyBannerWidthRate: CGFloat = 71 / 375
    private let bannerListWidthRate: CGFloat = 116 / 375

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        bind()
        viewModel.input.load.value = ()
    }

    override func loadView() {
        super.loadView()
        Bundle(for: HomeVC.self).loadNibNamed("\(HomeVC.self)", owner: self, options: nil)
    }
}

// MARK: - DataBinding

private extension HomeVC {
    func bind() {
        // TableView的資料
        viewModel.output.resultListObservable
            .on(queue: DispatchQueue.main)
            .bind { [weak self] dataSource in
                guard let self else { return }
                self.dataSource = dataSource
            }
        // ShimmerLoading
        viewModel.output.isLoading
            .on(queue: DispatchQueue.main)
            .bind { [weak self] isLoading in
                guard let self,
                      let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? AccountBalanceTableViewCell
                else {
                    return
                }
                cell.setLoadingView(status: isLoading)
            }
    }
}

// MARK: - Private Methods

private extension HomeVC {
    @objc func refresh() {
        viewModel.input.reload.value = ()
        refreshControl.endRefreshing()
    }
}

// MARK: - Init

private extension HomeVC {
    func commonInit() {
        // tableView 初始化
        tableView.delegate = self
        tableView.dataSource = self
        for id in CellConstant.allCases {
            tableView.register(UINib(nibName: id.rawValue, bundle: nil), forCellReuseIdentifier: id.rawValue)
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")

        // refreshControl初始化
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeVC.refresh), for: UIControl.Event.valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "loading...")
        tableView.addSubview(refreshControl)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource[indexPath.row]
        guard let model,
              let cell = tableView.dequeueReusableCell(withIdentifier: identifier(for: model), for: indexPath) as? ConfigurableCell
        else {
            return UITableViewCell()
        }
        cell.configure(with: model)
        cell.set(delegate: self)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath.row] {
        case .emptyBanner:
            let height = emptyBannerWidthRate * tableView.bounds.width
            return height
        case .bannerList:
            let height = bannerListWidthRate * tableView.bounds.width
            return height
        default:
            return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: HomeTopTableViewCellDelegate

extension HomeVC: HomeTopTableViewCellDelegate {
    func navgationToNotificationVC(cell: HomeTopTableViewCell, notificationModels: [NotificationModel]) {
        let vc = NotificationVC(dataSource: notificationModels)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: PaymentMethodTableViewCellDelegate

extension HomeVC: PaymentMethodTableViewCellDelegate {
    func paymentMethodTableViewCell(_ paymentMethodTableViewCell: PaymentMethodTableViewCell, didSelectMethod: PaymentMethod) {
        // TODO: 看你想做什麼
        print("paymentMethodTableViewCell didSelect Method:\(didSelectMethod)")
    }
}

// MARK: FavoriteTableViewCellDelegate

extension HomeVC: FavoriteTableViewCellDelegate {
    func favoriteTableViewCell(_ cell: FavoriteTableViewCell, selectFavorite: FavoriteModel) {
        // TODO: 看你想做什麼
        print("FavoriteTableViewCell didSelect Favorite:\(selectFavorite)")
    }
}

// MARK: BannerTableViewCellDelegate

extension HomeVC: BannerTableViewCellDelegate {
    func bannerTableViewCell(_ cell: BannerTableViewCell, selectBanner: BannerModel) {
        // TODO: 看你想做什麼
        print("BannerTableViewCell didSelect Banner:\(selectBanner)")
    }
}

// MARK: HomeVC.CellConstant

extension HomeVC {
    func identifier(for model: HomeViewModel.MyAcconutViewType) -> String {
        switch model {
        case .accountTop:
            return CellConstant.homeTopTableViewCell.rawValue
        case .accountBalance:
            return CellConstant.accountBalanceTableViewCell.rawValue
        case .paymentMethod:
            return CellConstant.paymentMethodTableViewCell.rawValue
        case .myFavoriteTitle:
            return CellConstant.myFavoriteTitleTableViewCell.rawValue
        case .favoriteList:
            return CellConstant.favoriteTableViewCell.rawValue
        case .bannerList:
            return CellConstant.bannerTableViewCell.rawValue
        case .emptyBanner:
            return CellConstant.bannerEmptyTableViewCell.rawValue
        }
    }

    enum CellConstant: String, CaseIterable {
        case homeTopTableViewCell = "HomeTopTableViewCell"
        case accountBalanceTableViewCell = "AccountBalanceTableViewCell"
        case paymentMethodTableViewCell = "PaymentMethodTableViewCell"
        case myFavoriteTitleTableViewCell = "MyFavoriteTitleTableViewCell"
        case favoriteTableViewCell = "FavoriteTableViewCell"
        case bannerTableViewCell = "BannerTableViewCell"
        case bannerEmptyTableViewCell = "BannerEmptyTableViewCell"
    }
}
