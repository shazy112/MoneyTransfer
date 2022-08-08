//
//  CurrencyExchangeRate.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/22/22.
//

import Foundation

// MARK: - CurrencyExchangeRate
struct CurrencyExchangeRate: Codable {
    let disclaimer: String?
    let license: String?
    let timestamp: Int?
    let base: String?
    let rates: [String: Double]?
}
