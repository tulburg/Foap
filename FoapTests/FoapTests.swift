//
//  FoapTests.swift
//  FoapTests
//
//  Created by Tolu Oluwagbemi on 27/04/2023.
//

import XCTest
import Apollo
@testable import Foap

final class FoapTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        UserDefaults.standard.removeObject(forKey: countryPopulationMap)
    }
    
    func testApolloEndpoint() throws {
        lazy var apollo = ApolloClient(url: URL(string: apolloEndPoint)!)
        
        apollo.fetch(query: CountriesQuery()) { result, error in
            XCTAssert(error == nil)
            XCTAssert(result != nil)
            XCTAssert(result?.data != nil)
            XCTAssert(result?.data?.item != nil)
        }
    }
    
    func testPopulationCorrectDecode() throws {
        let request = Linker(path: "Poland") { data, response, error in
            XCTAssert(error == nil)
            let responseData = PopulationResponse(data!.json() as NSDictionary)
            XCTAssert(responseData.data!.count > 0)
            XCTAssert((responseData.data![0].name != nil))
            XCTAssert((responseData.data![0].population != nil))
            
        }
    }
    
    func testCacheManagerStorage() throws {
        lazy var cacheManager = CountryCacheManager.shared()
        
        cacheManager?.saveCountry(withCode: "TEST", population: 100)
        let population = cacheManager?.getCountryWithCode("TEST")
        XCTAssertTrue(population == 100)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
