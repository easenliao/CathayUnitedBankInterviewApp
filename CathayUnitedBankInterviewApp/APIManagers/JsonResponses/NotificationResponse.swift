//
//  NotificationInfo.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/20.
//

import Foundation

// MARK: - NotificationResponse

struct NotificationResponse: Codable {
    let status: Bool
    let updateDateTime: String
    let title: String
    let message: String
}

extension NotificationResponse {
    func toModel() -> NotificationModel {
        NotificationModel(status: status,
                          updateDateTime: updateDateTime,
                          title: title,
                          message: message)
    }
}
