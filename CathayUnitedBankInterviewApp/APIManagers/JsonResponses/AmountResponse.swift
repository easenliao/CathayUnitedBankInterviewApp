//
//  AccountList.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/20.
//

import Foundation

struct AmountResponse: Codable {
    var account: String
    var curr: String
    var balance: Double
}
