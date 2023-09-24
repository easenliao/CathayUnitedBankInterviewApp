//
//  BannerResponse.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/20.
//

import Foundation
struct BannerResponse: Codable {
    let adSeqNo: Int
    let linkUrl: String
}

extension BannerResponse {
    func toModel() -> BannerModel {
        .init(adSeqNo: adSeqNo, linkUrl: linkUrl)
    }
}
