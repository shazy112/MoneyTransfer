//
//  CurrencyExchangeRateViewModel.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/22/22.
//

import Foundation
import UIKit
class SendMoneyViewModel {
    
    var repository: SendMoneyRepositoryProtocol?
    var reciepentsCountryTextFieldTappedCallback: ((CurrenciesCallBack) -> Void)?
    var vmCallbacks: ((CurrenciesCallBack) -> Void)?
    var phoneInput: Bool = false
    var convert: String?
    var currencies: CurrencyExchangeRate?
    
    
    init(repository: SendMoneyRepositoryProtocol = SendMoneyRepository()) {
        self.repository = repository
    }
    
    var sendMoneyResult: MoneyTransfer? {
        didSet {
            if let vmCallbacks = vmCallbacks, let result = sendMoneyResult {
                vmCallbacks(.moneyTransferResult(result: result))
            }
        }
    }
    
    var numberOfRows: Int? {
        return currencies?.rates?.count
    }
    
    var failedToFetchCurrencies: String? {
        didSet {
            if let vmCallbacks = vmCallbacks {
                vmCallbacks(.unableToFetchCurrencies(error: failedToFetchCurrencies ?? ""))
            }
        }
    }
    
    var countrySelectedForConversion: CountryInformation? {
        didSet {
            enablePhoneNumberInput()
            if let convert = convert, !convert.isEmpty, let countrySelectedForConversion = countrySelectedForConversion, let currencyAbbreviation = countrySelectedForConversion.currencyAbbreviation {
                doCalculation(inputAmount: convert, currencyAbbreviation: currencyAbbreviation)
            }
        }
    }
    
    func countriesTextFieldTapped() {
        if let vmCallbacks = vmCallbacks {
            vmCallbacks(.showCountriesList)
        }
    }
    
    func amountEntered(text: String) {
        convert = text
        guard let countrySelectedForConversion = countrySelectedForConversion, let currencyAbbreviation = countrySelectedForConversion.currencyAbbreviation, !currencyAbbreviation.isEmpty else {
            return
        }
        doCalculation(inputAmount: text, currencyAbbreviation: currencyAbbreviation)
    }
    
    private func currenciesFethced() {
        if let vmCallbacks = vmCallbacks {
            vmCallbacks(.currenciesFetched)
        }
    }
    
    func validateAndSendRequest(firstName: String, lastName: String, country: String, phoneNumber: String, countryCode: String, transferAmount: String, receivedAmout: String) -> Bool {
        let completePhoneNumber = "\(countryCode.dropFirst())\(phoneNumber)"
        
        if firstName.isEmpty {
            sendMoneyResult = .failure(MoneyTransferErrors.firstNameEmpty.description)
            return false
        }
        else if lastName.isEmpty {
            sendMoneyResult = .failure(MoneyTransferErrors.lastNameEmpty.description)
            return false
        }
        else if country.isEmpty {
            sendMoneyResult = .failure(MoneyTransferErrors.countryEmpty.description)
            return false
        }
        else if phoneNumber.isEmpty {
            sendMoneyResult = .failure(MoneyTransferErrors.phoneNumberEmpty.description)
            return false
        }
        else if let selectedCountry = countrySelectedForConversion, let regex = selectedCountry.regex, !completePhoneNumber.isValidPhoneNumber(regex: regex) {
            sendMoneyResult = .failure(MoneyTransferErrors.invalidPhoneNumber.description)
            return false
        }
        else if transferAmount.isEmpty {
            sendMoneyResult = .failure(MoneyTransferErrors.transferAmountEmpty.description)
            return false
        }
        else {
            let sendMoneyRequestModel = SendMoneyRequestModel(firstName: firstName,
                                                              lastName: lastName,
                                                              country: country,
                                                              phoneNumber: phoneNumber,
                                                              sendAmount: transferAmount,
                                                              receivedAmount: receivedAmout)
            sendMoneyResult = .success(sendMoneyRequestModel, "Your money has been sent successfully!")
            return true
        }
    }
    
    func containsBinary(string: String) -> Bool {
        return string.containsValidCharacter
    }
    
    func convertToDecimal(binary: String?) -> Int? {
        guard let binary = binary else {
            return nil
        }
        return Int(binary, radix: 2)
    }
    
    func convertToBinary(decimalValue: Int) -> String? {
        return String(decimalValue, radix: 2)
    }
    
    private func enablePhoneNumberInput() {
        if let vmCallbacks = vmCallbacks, !phoneInput {
            phoneInput.toggle()
            vmCallbacks(.enablePhoneNumberInput)
        }
    }
    
    private func fetching() {
        if let vmCallbacks = vmCallbacks {
            vmCallbacks(.fetching)
        }
    }
    
    //This Method calculates all the conversion from binary input to binary output based on the currency and to the local currency as well and then responds back to the VC.
    
    func doCalculation(inputAmount: String, currencyAbbreviation: String = "") {
        if let currencies = currencies, let decimalValue = convertToDecimal(binary: inputAmount) {
            let value = currencies.rates?[currencyAbbreviation] ?? 0.0
            let amountInActualCurrency = Int(value) * decimalValue
            let amountInBinay = convertToBinary(decimalValue: amountInActualCurrency)
            if let vmCallbacks = vmCallbacks {
                vmCallbacks(.convertedAmount(amountInActualCurrency: String(amountInActualCurrency), amountInBinary: amountInBinay ?? "", selectedCountry: currencyAbbreviation))
            }
        }
    }
    
    //Fetches currencies from the API
    func getCurrencies() async {
        fetching()
        do {
            if let currencies = try await repository?.fetchCurrencyExchangeRate() {
                self.currencies = currencies
                currenciesFethced()
            } else {
                failedToFetchCurrencies = "No Currencies Were Fetched"
            }
        }
        catch {
            if let err = error as? APIError {
                failedToFetchCurrencies = err.customDescription
            }
            else {
                failedToFetchCurrencies = error.localizedDescription
            }
        }
    }
}
