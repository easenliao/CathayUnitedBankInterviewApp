//
//  APIManager.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/20.
//

import Foundation

// MARK: - NotificationManager

protocol NotificationManager {
    func getEmptyNotification(completion: @escaping (GeneralResponse<[NotificationResponse]>?) -> Void)

    func getNotification(completion: @escaping (GeneralResponse<[NotificationResponse]>?) -> Void)
}

// MARK: - TheAmountManager

protocol TheAmountManager {
    func getFirstUSDSaving(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void)

    func getFirstUSDFixedDeposited(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void)

    func getFirstUSDDigital(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void)

    func getFirstKHRSaving(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void)

    func getFirstKHRFixedDeposited(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void)

    func getFirstKHRDigital(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void)

    func getRefreshUSDSaving(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void)

    func getRefreshUSDFixedDeposited(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void)

    func getRefreshUSDDigital(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void)

    func getRefreshKHRSaving(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void)

    func getRefreshKHRFixedDeposited(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void)

    func getRefreshKHRDigital(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void)
}

// MARK: - FavoriteListManager

protocol FavoriteListManager {
    func getEmptyFavoriteList(completion: @escaping (GeneralResponse<[FavoriteResponse]>?) -> Void)

    func getFavoriteList(completion: @escaping (GeneralResponse<[FavoriteResponse]>?) -> Void)
}

// MARK: - BannerManager

protocol BannerManager {
    func getBanner(completion: @escaping (GeneralResponse<[BannerResponse]>?) -> Void)
}

// MARK: - APIManager

class APIManager {
    static let shared = APIManager()
}

// MARK: NotificationManager

extension APIManager: NotificationManager {
    func getEmptyNotification(completion: @escaping (GeneralResponse<[NotificationResponse]>?) -> Void) {
        guard let url = URL(string: APIUrls.NotificationList.empty)
        else {
            return
        }
        fetchData(from: url) { response in
            completion(response)
        }
    }

    func getNotification(completion: @escaping (GeneralResponse<[NotificationResponse]>?) -> Void) {
        guard let url = URL(string: APIUrls.NotificationList.notEmpty)
        else {
            return
        }
        fetchData(from: url) { response in
            completion(response)
        }
    }
}

// MARK: TheAmountManager

extension APIManager: TheAmountManager {
    func getFirstUSDSaving(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void) {
        guard let url = URL(string: APIUrls.TheAmount.FirstOpen.USD.savings)
        else {
            return
        }
        fetchData(from: url) { response in
            completion(response)
        }
    }

    func getFirstUSDFixedDeposited(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void) {
        guard let url = URL(string: APIUrls.TheAmount.FirstOpen.USD.fixedDeposited)
        else {
            return
        }
        fetchData(from: url) { response in
            completion(response)
        }
    }

    func getFirstUSDDigital(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void) {
        guard let url = URL(string: APIUrls.TheAmount.FirstOpen.USD.digital)
        else {
            return
        }
        fetchData(from: url) { response in
            completion(response)
        }
    }

    func getFirstKHRSaving(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void) {
        guard let url = URL(string: APIUrls.TheAmount.FirstOpen.KHR.savings)
        else {
            return
        }
        fetchData(from: url) { response in
            completion(response)
        }
    }

    func getFirstKHRFixedDeposited(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void) {
        guard let url = URL(string: APIUrls.TheAmount.FirstOpen.KHR.fixedDeposited)
        else {
            return
        }
        fetchData(from: url) { response in
            completion(response)
        }
    }

    func getFirstKHRDigital(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void) {
        guard let url = URL(string: APIUrls.TheAmount.FirstOpen.KHR.digital)
        else {
            return
        }
        fetchData(from: url) { response in
            completion(response)
        }
    }

    func getRefreshUSDSaving(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void) {
        guard let url = URL(string: APIUrls.TheAmount.PullRefresh.USD.savings)
        else {
            return
        }
        fetchData(from: url) { response in
            completion(response)
        }
    }

    func getRefreshUSDFixedDeposited(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void) {
        guard let url = URL(string: APIUrls.TheAmount.PullRefresh.USD.fixedDeposited)
        else {
            return
        }
        fetchData(from: url) { response in
            completion(response)
        }
    }

    func getRefreshUSDDigital(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void) {
        guard let url = URL(string: APIUrls.TheAmount.PullRefresh.USD.digital)
        else {
            return
        }
        fetchData(from: url) { response in
            completion(response)
        }
    }

    func getRefreshKHRSaving(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void) {
        guard let url = URL(string: APIUrls.TheAmount.PullRefresh.KHR.savings)
        else {
            return
        }
        fetchData(from: url) { response in
            completion(response)
        }
    }

    func getRefreshKHRFixedDeposited(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void) {
        guard let url = URL(string: APIUrls.TheAmount.PullRefresh.KHR.fixedDeposited)
        else {
            return
        }
        fetchData(from: url) { response in
            completion(response)
        }
    }

    func getRefreshKHRDigital(completion: @escaping (GeneralResponse<[AmountResponse]>?) -> Void) {
        guard let url = URL(string: APIUrls.TheAmount.PullRefresh.KHR.digital)
        else {
            return
        }
        fetchData(from: url) { response in
            completion(response)
        }
    }
}

// MARK: FavoriteListManager

extension APIManager: FavoriteListManager {
    func getEmptyFavoriteList(completion: @escaping (GeneralResponse<[FavoriteResponse]>?) -> Void) {
        guard let url = URL(string: APIUrls.FavoriteList.empty)
        else {
            return
        }
        fetchData(from: url) { response in
            completion(response)
        }
    }

    func getFavoriteList(completion: @escaping (GeneralResponse<[FavoriteResponse]>?) -> Void) {
        guard let url = URL(string: APIUrls.FavoriteList.notEmpty)
        else {
            return
        }
        fetchData(from: url) { response in
            completion(response)
        }
    }
}

// MARK: BannerManager

extension APIManager: BannerManager {
    func getBanner(completion: @escaping (GeneralResponse<[BannerResponse]>?) -> Void) {
        guard let url = URL(string: APIUrls.adBanner)
        else {
            return
        }
        fetchData(from: url) { response in
            completion(response)
        }
    }
}

private extension APIManager {
    func fetchData<T: Codable>(from url: URL, completion: @escaping (GeneralResponse<T>?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else {
                print("Error fetching data:", error ?? "No error description")
                completion(nil)
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(GeneralResponse<T>.self, from: data)
                completion(decodedData)
            } catch {
                print("Error decoding data:", error)
                completion(nil)
            }

        }.resume()
    }
}
