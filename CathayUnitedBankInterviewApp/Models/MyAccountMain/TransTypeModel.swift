//
//  TransTypeModel.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/24.
//

import Foundation
enum TransTypeModel: String {
    case cubc = "CUBC"
    case mobile = "Mobile"
    case pmf = "PMF"
    case creditCard = "CreditCard"

    var iconName: String {
        switch self {
        case .cubc:
            return "button00ElementScrollTree"
        case .mobile:
            return "button00ElementScrollMobile"
        case .pmf:
            return "button00ElementScrollBuilding"
        case .creditCard:
            return "button00ElementScrollCreditCard"
        }
    }
}
