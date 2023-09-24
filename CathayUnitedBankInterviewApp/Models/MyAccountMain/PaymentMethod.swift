//
//  PaymentMethod.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/21.
//

import Foundation

struct PaymentMethod {
    var type: PaymentMethodType
    var imageName: String
    var imageTitle: String
}

enum PaymentMethodType {
    case transfer
    case payment
    case utility
    case qrScan
    case myQRCode
    case topUp
}
