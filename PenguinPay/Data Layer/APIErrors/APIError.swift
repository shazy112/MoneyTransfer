//
//  APIError.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/21/22.
//

import Foundation

enum APIError: Error {
    
    case jsonConversionFailed
    case unknownError
    case invalidResponse
    case incorrectURLReceived
    
    var customDescription: String {
        switch self {
        case .incorrectURLReceived:
            return  "URL received was not correct!"
        case .invalidResponse:
            return "Invalid Response received."
        case .unknownError:
            return "Unknown Error occoured."
        case .jsonConversionFailed:
            return "Json conversion failed"
        }
    }
}
