//
//  SendMoneyMock.swift
//  PenguinPayTests
//
//  Created by Sheearz Ahmed on 6/27/22.
//

import Foundation
@testable import PenguinPay

class SendMoneyMock: SendMoneyRepositoryProtocol {
    
    var apiManager: APIManager
    var currenciesFetched = false
    var vmCallbacks: ((CurrenciesCallBack) -> Void)?
    
    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }
    
    func fetchCurrencyExchangeRate() async throws -> CurrencyExchangeRate {
        currenciesFetched = true
        if let vmCallbacks = vmCallbacks {
            vmCallbacks(.currenciesFetched)
        }
        return CurrencyExchangeRate(disclaimer: nil, license: nil, timestamp: nil, base: nil, rates: nil)
    }
    
   private func convertToDecimal(binary: String?) -> Int? {
        guard let binary = binary else {
            return nil
        }
        return Int(binary, radix: 2)
    }
    
   private func convertToBinary(decimalValue: Int) -> String? {
        return String(decimalValue, radix: 2)
    }
    
    func doCalculationForMock(inputAmount: String, currencyAbbreviation: String) -> String {
        let currency = CurrencyExchangeRate(disclaimer: nil, license: nil, timestamp: nil, base: nil, rates: ["KES": 117])
        if let decimalValue = convertToDecimal(binary: inputAmount) {
            let value = currency.rates?["KES"] ?? 0.0
            let amountInActualCurrency = Int(value) * decimalValue
            let amountInBinay = convertToBinary(decimalValue: amountInActualCurrency)
            return amountInBinay ?? ""
        }
        return ""
    }
}
