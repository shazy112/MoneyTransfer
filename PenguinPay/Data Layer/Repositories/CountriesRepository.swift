//
//  CountriesRepository.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/22/22.
//

import Foundation

protocol CountriesRepositoryProtocol {
    var localDataManager: LocalDataManager {get}
    func fetchCountries() async throws -> [CountryInformation]
}

class CountriesRepository: CountriesRepositoryProtocol {
    
    var localDataManager: LocalDataManager
    
    init(localDataManager: LocalDataManager = LocalDataManager()) {
        self.localDataManager = localDataManager
    }
    
    func fetchCountries() async throws -> [CountryInformation] {
        do {
            let countryInfo = try await localDataManager.fetchData(type: [CountryInformation].self,
                                                                   fileName: .countyInfo,
                                                                   fileExtension: .json)
            return countryInfo
        }
        catch {
            throw APIError.jsonConversionFailed
        }
    }
}
