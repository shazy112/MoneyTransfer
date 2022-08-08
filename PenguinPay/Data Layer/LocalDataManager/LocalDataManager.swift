//
//  LocalDataManager.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/21/22.
//

import Foundation

enum FileName: String {
    case countyInfo = "CountryInfo"
}

enum FileExtension: String {
    case json
}

protocol LocalDataManagerProtocol {
    func fetchData<T: Codable>(type: T.Type,
                               fileName: FileName,
                               fileExtension: FileExtension) async throws -> T
}

class LocalDataManager: LocalDataManagerProtocol {
    
    func fetchData<T: Codable> (type: T.Type,
                                fileName: FileName,
                                fileExtension: FileExtension) async throws -> T {
        
        guard let url = Bundle.main.url(forResource: fileName.rawValue, withExtension: fileExtension.rawValue) else {
            throw APIError.unknownError
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw APIError.jsonConversionFailed
        }
    }
    
}

