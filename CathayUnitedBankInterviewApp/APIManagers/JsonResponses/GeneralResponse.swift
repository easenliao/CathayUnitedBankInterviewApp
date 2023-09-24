//
//  GeneralResponse.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/20.
//

import Foundation

struct GeneralResponse<T: Codable>: Codable {
    var msgCode: String
    var msgContent: String
    var result: ResultDataResponse<T>?
}
