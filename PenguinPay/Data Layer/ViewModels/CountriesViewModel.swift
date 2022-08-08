//
//  CountriesViewModel.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/22/22.
//

import Foundation
class CountriesViewModel {
    
    var repository: CountriesRepositoryProtocol?
    var vmCallbacks: ((CountriesCallBack) -> Void)?
    var countries: [CountryInformation] = []
    
    init(repository: CountriesRepositoryProtocol = CountriesRepository()) {
        self.repository = repository
    }
    
    var numberOfRows: Int? {
        return countries.count
    }
    
    var selectedCountry: CountryInformation? {
        didSet {
            if let vmCallbacks = vmCallbacks, let selectedCountry = selectedCountry {
                vmCallbacks(.countrySelected(country: selectedCountry))
            }
        }
    }
    
    var failedToFetchCountries: String? {
        didSet {
            if let vmCallbacks = vmCallbacks {
                vmCallbacks(.unableToFetchCountries(error: failedToFetchCountries ?? ""))
            }
        }
    }
    
    func countriesFethced() {
        if let vmCallbacks = vmCallbacks {
            vmCallbacks(.countriesFetched)
        }
    }
    
    func fetchCountries() async {
        do {
            if let countries = try await repository?.fetchCountries() {
                self.countries = countries
                countriesFethced()
            } else {
                failedToFetchCountries = "No Countries Were Fetched"
            }
        }
        catch {
            if let err = error as? APIError {
                failedToFetchCountries = err.customDescription
            }
            else {
                failedToFetchCountries = error.localizedDescription
            }
        }
    }
}

enum CountriesCallBack {
    case countriesFetched
    case countrySelected(country: CountryInformation)
    case unableToFetchCountries(error: String)
}
