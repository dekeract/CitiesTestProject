//
//  CityLoaderTests.swift
//  CitiesTestProjectTests
//
//  Created by Dima Nikolaenko on 28.06.2020.
//  Copyright © 2020 Personal. All rights reserved.
//

import XCTest
@testable import CitiesTestProject

class CityLoaderTests: XCTestCase {
    
    var sut: CityLoader!
    
    override func setUp() {
        super.setUp()
        
        sut = CityLoader()
    }

    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }

    func testCityLoading() {
        let promise = expectation(description: "City loading completion is invoked")
        var error: Error?
        var cities: [City] = []
        
        sut.load { (result) in
            switch result {
            case .success(let items):
                cities = items
            case .failure(let resultError):
                error = resultError
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(error)
        XCTAssertGreaterThan(cities.count, 0, "Cities were not loaded")
    }
}
