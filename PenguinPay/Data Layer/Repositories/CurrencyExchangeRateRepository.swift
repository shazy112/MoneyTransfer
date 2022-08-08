//
//  CurrencyExchangeRateRepository.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/22/22.
//

import Foundation

protocol SendMoneyRepositoryProtocol {
    var apiManager: APIManager { get }
    func fetchCurrencyExchangeRate() async throws -> CurrencyExchangeRate
    func doCalculationForMock(inputAmount: String, currencyAbbreviation: String) -> String
}

class SendMoneyRepository: SendMoneyRepositoryProtocol {
    func doCalculationForMock(inputAmount: String, currencyAbbreviation: String) -> String {
        return ""
    }
    
    var apiManager: APIManager
    
    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }
    
    func fetchCurrencyExchangeRate() async throws -> CurrencyExchangeRate {
        let currencyExchangeRateRequest = CurrencyExchangeRateRequest()
        let createRequest = try currencyExchangeRateRequest.createURLRequest()
        do {
            return try await apiManager.fetch(type: CurrencyExchangeRate.self,
                                              with: createRequest)
        }
        catch {
            throw APIError.jsonConversionFailed
        }
    }
}
