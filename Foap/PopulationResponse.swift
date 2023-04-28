//
//  PopulationResponse.swift
//  Foap
//
//  Created by Tolu Oluwagbemi on 27/04/2023.
//

import Foundation

class PopulationResponse: ResponseProtocol {
    var data: [PopulationData]?
    required init(_ dict: NSDictionary) {
        data = dict.list("data")
    }
    
    // PopulationData filters to get only name and population
    class PopulationData: ResponseProtocol {
        var name: String?
        var population: Int?
        required init(_ dict: NSDictionary) {
            name = dict.string("name")
            population = dict.int("population")
        }
    }
}

