//
//  CurrencyExchangeRateRequest.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/22/22.
//

import Foundation

class CurrencyExchangeRateRequest: URLRequestProtocol {
    var parameters: [String : String] {
        return ["app_id": apiKey]
    }
    
    var httpMethod: String {
        return NetworkEssentials.HttpMethods.get.rawValue
    }
    
    var scheme: String {
        return "https"
    }
    
    var route: String {
        return NetworkEssentials.Route.currency.rawValue
    }
}
