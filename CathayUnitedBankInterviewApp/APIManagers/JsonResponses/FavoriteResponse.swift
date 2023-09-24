//
//  FavoriteInfo.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/20.
//

import Foundation

// MARK: - FavoriteResponse

struct FavoriteResponse: Codable {
    let nickname: String
    let transType: TransTypeResponse
}

extension FavoriteResponse {
    func toModel() -> FavoriteModel {
        let transTypeModel: TransTypeModel
        switch transType {
        case .cubc:
            transTypeModel = .cubc
        case .mobile:
            transTypeModel = .mobile
        case .pmf:
            transTypeModel = .pmf
        case .creditCard:
            transTypeModel = .creditCard
        }
        return FavoriteModel(nickname: nickname, transType: transTypeModel)
    }
}
