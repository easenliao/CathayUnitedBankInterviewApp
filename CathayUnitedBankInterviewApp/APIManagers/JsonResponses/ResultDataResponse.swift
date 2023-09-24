//
//  ResultData.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/20.
//

import Foundation

// MARK: - ResultData

struct ResultDataResponse<T: Codable>: Codable {
    var list: T?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicKey.self)
        let key = container.allKeys.first
        if let key {
            list = try container.decode(T.self, forKey: key)
        } else {
            list = nil
        }
    }
}

// MARK: - DynamicKey

struct DynamicKey: CodingKey {
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    var intValue: Int?
    init?(intValue: Int) {
        nil
    }
}
