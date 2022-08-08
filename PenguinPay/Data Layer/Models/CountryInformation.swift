//
//  CountryInformation.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/21/22.
//

import Foundation
struct CountryInformation: Codable {
    
    var country: String?
    var currencyAbbreviation: String?
    var phonePrefix: String?
    var countryFlag: String?
    var regex: String?
    var image: String?
    
    enum CodingKeys: String, CodingKey {
        case country, regex, image
        case currencyAbbreviation = "currency_abbreviation"
        case phonePrefix = "phone_prefix"
        case countryFlag = "country_flag"
    }
}

