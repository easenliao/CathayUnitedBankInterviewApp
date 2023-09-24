//
//  HomeViewModel.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/21.
//

import Foundation

// MARK: - HomeViewModel

class HomeViewModel {
    // MARK: - Public Properties

    let input = Input()
    let output = Output()

    // MARK: - Private  Properties

    private let apiManager: APIManager

    init(apiManager: APIManager) {
        self.apiManager = apiManager
        bind()
    }
}

// MARK: - Binding

private extension HomeViewModel {
    func bind() {
        input.load
            .bind { [weak self] _ in
                guard let self else { return }
                fetchFirstData { data in
                    self.output.resultListObservable.value = data
                }
            }
        input.reload
            .bind { [weak self] _ in
                guard let self else { return }
                output.isLoading.value = true
                fetchRefreshData { data in
                    self.output.resultListObservable.value = data
                    self.output.isLoading.value = false
                }
            }
    }
}

// MARK: - Private Methods

private extension HomeViewModel {
    func fetchFirstData(completion: @escaping ([Int: MyAcconutViewType]) -> Void) {
        var model: [Int: MyAcconutViewType] = [2: .paymentMethod(buildPaymentMethod()),
                                               3: .myFavoriteTitle,
                                               5: .emptyBanner]
        let group = DispatchGroup()
        group.enter()
        fetchFirstAmountModel { amountModel in
            model[1] = .accountBalance(amount: amountModel)
            group.leave()
        }

        fetchData(group,
                  using: apiManager.getEmptyNotification,
                  modelUpdater: {
                      model[0] = .accountTop($0.map { $0.toModel() })
                  },
                  defaultData: [])
        fetchData(group,
                  using: apiManager.getEmptyFavoriteList,
                  modelUpdater: {
                      model[4] = .favoriteList($0.map { $0.toModel() })
                  },
                  defaultData: [])

        group.notify(queue: .main) {
            completion(model)
        }
    }

    func fetchRefreshData(completion: @escaping ([Int: MyAcconutViewType]) -> Void) {
        var model: [Int: MyAcconutViewType] = [2: .paymentMethod(buildPaymentMethod()),
                                               3: .myFavoriteTitle]
        let group = DispatchGroup()
        group.enter()
        fetchRefreshAmountModel { amountModel in
            model[1] = .accountBalance(amount: amountModel)
            group.leave()
        }

        fetchData(group,
                  using: apiManager.getNotification,
                  modelUpdater: {
                      model[0] = .accountTop($0.map { $0.toModel() })
                  },
                  defaultData: [])
        fetchData(group,
                  using: apiManager.getFavoriteList,
                  modelUpdater: {
                      model[4] = .favoriteList($0.map { $0.toModel() })
                  },
                  defaultData: [])
        fetchData(group,
                  using: apiManager.getBanner,
                  modelUpdater: {
                      model[5] = .bannerList($0
                          .map { $0.toModel() }
                          .sorted(by: { $0.adSeqNo < $1.adSeqNo }))
                  },
                  defaultData: [])
        // 為了Loading 效果增加延遲
        group.enter()
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            group.leave()
        }
        group.notify(queue: .main) {
            completion(model)
        }
    }

    func fetchData<T>(_ group: DispatchGroup,
                      using fetcher: (@escaping (GeneralResponse<T>?) -> Void) -> Void,
                      modelUpdater: @escaping (T) -> Void, defaultData: T)
    {
        group.enter()
        fetcher { response in
            defer { group.leave() }
            let data = response?.result?.list ?? defaultData
            modelUpdater(data)
        }
    }

    func fetchFirstAmountModel(completion: @escaping (AmountTotal) -> Void) {
        let amountAPIManager: TheAmountManager = apiManager
        let group = DispatchGroup()
        var summaryUsd: Decimal = 0
        var summaryKhr: Decimal = 0
        fetchAmountList(group, using: amountAPIManager.getFirstUSDSaving) { list in
            summaryUsd += list
                .filter { $0.curr == "USD" }
                .map { Decimal(floatLiteral: $0.balance) }
                .reduce(Decimal(0)) { $0 + $1 }
        }
        fetchAmountList(group, using: amountAPIManager.getFirstUSDFixedDeposited) { list in summaryUsd += list
            .filter { $0.curr == "USD" }
            .map { Decimal(floatLiteral: $0.balance) }
            .reduce(Decimal(0)) { $0 + $1 }
        }
        fetchAmountList(group, using: amountAPIManager.getFirstUSDDigital) { list in summaryUsd += list
            .filter { $0.curr == "USD" }
            .map { Decimal(floatLiteral: $0.balance) }
            .reduce(Decimal(0)) { $0 + $1 }
        }
        fetchAmountList(group, using: amountAPIManager.getFirstKHRSaving) { list in summaryKhr += list
            .filter { $0.curr == "KHR" }
            .map { Decimal(floatLiteral: $0.balance) }
            .reduce(Decimal(0)) { $0 + $1 }
        }
        fetchAmountList(group, using: amountAPIManager.getFirstKHRFixedDeposited) { list in summaryKhr += list
            .filter { $0.curr == "KHR" }
            .map { Decimal(floatLiteral: $0.balance) }
            .reduce(Decimal(0)) { $0 + $1 }
        }
        fetchAmountList(group, using: amountAPIManager.getFirstKHRDigital) { list in summaryKhr += list
            .filter { $0.curr == "KHR" }
            .map { Decimal(floatLiteral: $0.balance) }
            .reduce(Decimal(0)) { $0 + $1 }
        }

        group.notify(queue: .main) {
            completion(AmountTotal(usd: summaryUsd, khr: summaryKhr))
        }
    }

    func fetchRefreshAmountModel(completion: @escaping (AmountTotal) -> Void) {
        let amountAPIManager: TheAmountManager = apiManager
        let group = DispatchGroup()
        var summaryUsd: Decimal = 0
        var summaryKhr: Decimal = 0
        fetchAmountList(group, using: amountAPIManager.getRefreshUSDSaving) { list in
            summaryUsd += list
                .filter { $0.curr == "USD" }
                .map { Decimal(floatLiteral: $0.balance) }
                .reduce(Decimal(0)) { $0 + $1 }
        }
        fetchAmountList(group, using: amountAPIManager.getRefreshUSDFixedDeposited) { list in summaryUsd += list
            .filter { $0.curr == "USD" }
            .map { Decimal(floatLiteral: $0.balance) }
            .reduce(Decimal(0)) { $0 + $1 }
        }
        fetchAmountList(group, using: amountAPIManager.getRefreshUSDDigital) { list in summaryUsd += list
            .filter { $0.curr == "USD" }
            .map { Decimal(floatLiteral: $0.balance) }
            .reduce(Decimal(0)) { $0 + $1 }
        }
        fetchAmountList(group, using: amountAPIManager.getRefreshKHRSaving) { list in summaryKhr += list
            .filter { $0.curr == "KHR" }
            .map { Decimal(floatLiteral: $0.balance) }
            .reduce(Decimal(0)) { $0 + $1 }
        }
        fetchAmountList(group, using: amountAPIManager.getRefreshKHRFixedDeposited) { list in summaryKhr += list
            .filter { $0.curr == "KHR" }
            .map { Decimal(floatLiteral: $0.balance) }
            .reduce(Decimal(0)) { $0 + $1 }
        }
        fetchAmountList(group, using: amountAPIManager.getRefreshKHRDigital) { list in summaryKhr += list
            .filter { $0.curr == "KHR" }
            .map { Decimal(floatLiteral: $0.balance) }
            .reduce(Decimal(0)) { $0 + $1 }
        }

        group.notify(queue: .main) {
            completion(AmountTotal(usd: summaryUsd, khr: summaryKhr))
        }
    }

    func fetchAmountList(_ group: DispatchGroup,
                         using fetcher: (@escaping (GeneralResponse<[AmountResponse]>?) -> Void) -> Void,
                         modelUpdater: @escaping ([AmountResponse]) -> Void)
    {
        group.enter()
        fetcher { response in
            defer { group.leave() }
            guard let list = response?.result?.list else { return }
            modelUpdater(list)
        }
    }

    func buildPaymentMethod() -> [PaymentMethod] {
        [PaymentMethod(type: .transfer,
                       imageName: "button00ElementMenuTransfer",
                       imageTitle: "Transfer"),
         PaymentMethod(type: .payment,
                       imageName: "button00ElementMenuPayment",
                       imageTitle: "Payment"),
         PaymentMethod(type: .utility,
                       imageName: "button00ElementMenuUtility",
                       imageTitle: "Utility"),
         PaymentMethod(type: .qrScan,
                       imageName: "button01Scan",
                       imageTitle: "QR pay scan"),
         PaymentMethod(type: .myQRCode,
                       imageName: "button00ElementMenuQRcode",
                       imageTitle: "My QR code"),
         PaymentMethod(type: .topUp,
                       imageName: "button00ElementMenuTopUp",
                       imageTitle: "Top up")]
    }
}

extension HomeViewModel {
    struct Input {
        var load: Observable<Void> = Observable()
        var reload: Observable<Void> = Observable()
    }

    struct Output {
        var resultListObservable: Observable<[Int: MyAcconutViewType]> = Observable([:])
        var isLoading: Observable<Bool> = Observable(false)
    }

    enum MyAcconutViewType: Equatable {
        case accountTop(_ data: [NotificationModel])
        case accountBalance(amount: AmountTotal)
        case paymentMethod(_ data: [PaymentMethod])
        case myFavoriteTitle
        case favoriteList(_ data: [FavoriteModel])
        case bannerList(_ data: [BannerModel])
        case emptyBanner

        static func == (lhs: HomeViewModel.MyAcconutViewType, rhs: HomeViewModel.MyAcconutViewType) -> Bool {
            switch (lhs, rhs) {
            case (.accountTop, .accountTop),
                 (.accountBalance, .accountBalance),
                 (.paymentMethod, .paymentMethod),
                 (.myFavoriteTitle, .myFavoriteTitle),
                 (.favoriteList, .favoriteList),
                 (.bannerList, .bannerList),
                 (.emptyBanner, .emptyBanner):
                return true
            default:
                return false
            }
        }
    }
}
