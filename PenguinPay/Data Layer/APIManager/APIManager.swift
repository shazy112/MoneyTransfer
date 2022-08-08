//
//  APIManager.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/22/22.
//

import Foundation
protocol APIManagerProtocol {
    var session: URLSession { get }
    func fetch<T: Decodable>(
        type: T.Type,
        with request: URLRequest) async throws -> T
}

class APIManager: APIManagerProtocol {
    
    var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetch<T: Decodable>(
        type: T.Type,
        with request: URLRequest) async throws -> T { 
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            do {
                return try JSONDecoder().decode(type, from: data)
            } catch {
                throw APIError.jsonConversionFailed
            }
        }
}
