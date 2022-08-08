//
//  CurrenciesCallBacks.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/27/22.
//

import Foundation
enum CurrenciesCallBack {
    case fetching
    case enablePhoneNumberInput
    case convertedAmount(amountInActualCurrency: String, amountInBinary: String, selectedCountry: String)
    case currenciesFetched
    case unableToFetchCurrencies(error: String)
    case showCountriesList
    case moneyTransferResult(result: MoneyTransfer)
}
