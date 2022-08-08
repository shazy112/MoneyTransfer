//
//  MoneyTransfers.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/27/22.
//

import Foundation
enum MoneyTransfer {
    case success(SendMoneyRequestModel, String)
    case failure(String)
}
