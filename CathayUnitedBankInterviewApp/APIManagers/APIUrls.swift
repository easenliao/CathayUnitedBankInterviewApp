//
//  APIUrls.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/20.
//

import Foundation
struct APIUrls {
    enum NotificationList {
        static let empty = "https://willywu0201.github.io/data/emptyNotificationList.json"
        static let notEmpty = "https://willywu0201.github.io/data/notificationList.json"
    }

    enum TheAmount {
        enum FirstOpen {
            enum USD {
                static let savings = "https://willywu0201.github.io/data/usdSavings1.json"
                static let fixedDeposited = "https://willywu0201.github.io/data/usdFixed1.json"
                static let digital = "https://willywu0201.github.io/data/usdDigital1.json"
            }

            enum KHR {
                static let savings = "https://willywu0201.github.io/data/khrSavings1.json"
                static let fixedDeposited = "https://willywu0201.github.io/data/khrFixed1.json"
                static let digital = "https://willywu0201.github.io/data/khrDigital1.json"
            }
        }

        enum PullRefresh {
            enum USD {
                static let savings = "https://willywu0201.github.io/data/usdSavings2.json"
                static let fixedDeposited = "https://willywu0201.github.io/data/usdFixed2.json"
                static let digital = "https://willywu0201.github.io/data/usdDigital2.json"
            }

            enum KHR {
                static let savings = "https://willywu0201.github.io/data/khrSavings2.json"
                static let fixedDeposited = "https://willywu0201.github.io/data/khrFixed2.json"
                static let digital = "https://willywu0201.github.io/data/khrDigital2.json"
            }
        }
    }

    enum FavoriteList {
        static let empty = "https://willywu0201.github.io/data/emptyFavoriteList.json"
        static let notEmpty = "https://willywu0201.github.io/data/favoriteList.json"
    }

    static let adBanner = "https://willywu0201.github.io/data/banner.json"
}
