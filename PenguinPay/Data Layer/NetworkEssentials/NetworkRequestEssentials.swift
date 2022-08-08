//
//  NetworkRequestEssentials.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/22/22.
//

import Foundation

class NetworkEssentials {
    
    enum HttpMethods: String {
        case get = "GET"
    }
    
    enum Route: String {
        case currency = "/api/latest.json"
    }
}
