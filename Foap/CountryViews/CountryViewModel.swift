//
//  CountryViewModel.swift
//  Foap
//
//  Created by Tolu Oluwagbemi on 28/04/2023.
//

import Foundation
import Apollo

class CountryViewModel {
    
    static let shared = {
        return CountryViewModel()
    }()
    
    /*
        Gets the country info using the apollo client
     */
    func getCountries(completion: @escaping (_ error: (any Error)?, _ result: [Country]) -> Void) {
        lazy var apollo = ApolloClient(url: URL(string: apolloEndPoint)!)
        apollo.fetch(query: CountriesQuery()){ result, error in
            guard error == nil else {
                completion(error, [])
                return;
            }
            var countries: [Country] = []
            result?.data?.item.forEach {
                var country = Country(name: $0.name, flag: $0.emoji, code: $0.code, currency: $0.currency, capital: $0.capital, native: $0.native, language: $0.languages.first?.name)
                if let population = CountryCacheManager.shared()?.getCountryWithCode($0.code) {
                    country.population = Int(truncating: population)
                }
                countries.append(country)
            }
            completion(nil, countries)
        }
    }
    
    /*
        Gets population of country using the population endpoint in the linker
        Caches the result using CountryCacheManager
     */
    func getPopulation(code: String, completion: @escaping (_ error: (any Error)?, _ population: Int) -> Void) {
        Linker(path: code) { data, response, error in
            guard error == nil else {
                completion(error, 0)
                return
            }
            let responseData = PopulationResponse(data!.json() as NSDictionary)
            if let country = responseData.data?.first {
                // Cache the currently fetch country population
                CountryCacheManager.shared()?.saveCountry(withCode: code, population: country.population!)
                completion(nil, country.population!)
            }
        }?.execute()
    }
    
    
}



