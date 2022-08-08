//
//  Request.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/22/22.
//

import Foundation

protocol URLRequestProtocol {
    
    var apiKey: String { get }
    var parameters: [String: String] { get }
    var hostURL: String {get}
    var httpMethod: String { get }
    var scheme: String {get}
    var route: String {get}
    
}

extension URLRequestProtocol {
    var hostURL: String {
        "openexchangerates.org"
    }
    
    var apiKey: String {
        return "0d1f45b045bb4140981c8e0e8a16d9f4"
    }
    
    func createURLRequest() throws -> URLRequest {
        
        var components = createURLComponents()
        if !parameters.isEmpty {
            components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        }
        
        guard let url = components.url else {
            throw  APIError.incorrectURLReceived
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }
    
    private func createURLComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = hostURL
        urlComponents.path = route
        return urlComponents
    }
}
