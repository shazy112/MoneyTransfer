//
//  MoneyTransferError.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/27/22.
//

import Foundation
enum MoneyTransferErrors {
    
    case firstNameEmpty
    case lastNameEmpty
    case countryEmpty
    case phoneNumberEmpty
    case transferAmountEmpty
    case invalidPhoneNumber
    
    var description: String {
        switch self {
        case .firstNameEmpty:
            return "Please enter First Name"
        case .lastNameEmpty:
            return "Please enter Last Name"
        case .countryEmpty:
            return "Plesae select a destination country to transfer money"
        case .phoneNumberEmpty:
            return  "Please enter Phone Number"
        case .transferAmountEmpty:
            return "Plese enter transfer amount to complete the transfer"
        case .invalidPhoneNumber:
            return "Invalid Phone Number entered, please enter a valid phone number to complete the transfer."
        }
    }
}
