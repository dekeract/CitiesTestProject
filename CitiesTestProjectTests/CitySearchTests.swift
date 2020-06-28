//
//  CitySearchTests.swift
//  CitiesTestProjectTests
//
//  Created by Dima Nikolaenko on 28.06.2020.
//  Copyright © 2020 Personal. All rights reserved.
//

import XCTest
@testable import CitiesTestProject

class CitySearchTests: XCTestCase {
    
    var sut: CitySearch!
    var citiesMock: [City]!

    override func setUp() {
        super.setUp()
        
        sut = CitySearch()
        let emptyCoordinate = Coordinate(latitude: 0, longitude: 0)
        citiesMock = [
            City(id: 0, name: "Alabama", country: "US", coordinate: emptyCoordinate),
            City(id: 0, name: "Albuquerque", country: "US", coordinate: emptyCoordinate),
            City(id: 0, name: "Anaheim", country: "US", coordinate: emptyCoordinate),
            City(id: 0, name: "Odessa", country: "UA", coordinate: emptyCoordinate),
            City(id: 0, name: "Odessa", country: "US", coordinate: emptyCoordinate),
            City(id: 0, name: "Sydney", country: "AU", coordinate: emptyCoordinate)
        ]
    }
    
    override func tearDown() {
        sut = nil
        citiesMock = nil
        
        super.tearDown()
    }

    func testSearchUppercase() {
        let searchText = "Alabama"
        
        let filteredCities = sut.filter(cities: citiesMock, with: searchText)
        
        XCTAssertEqual(filteredCities.count, 1, "Found more or less than 1 Alabama city in mocks")
    }
    
    func testSearchLowercase() {
        let searchText = "alabama"
        
        let filteredCities = sut.filter(cities: citiesMock, with: searchText)
        
        XCTAssertEqual(filteredCities.count, 1, "Found more or less than 1 alabama city in mocks")
    }
    
    func testSearchPartText() {
        let searchText = "al"
        
        let filteredCities = sut.filter(cities: citiesMock, with: searchText)
        
        XCTAssertEqual(filteredCities.count, 2, "Found more or less than 2 cities started with al in mocks")
    }
    
    func testSearchWithCountry() {
        let searchText = "Odessa, US"
        
        let filteredCities = sut.filter(cities: citiesMock, with: searchText)
        
        XCTAssertEqual(filteredCities.count, 1, "Found more or less than 1 city Odessa, US")
    }
    
    func testSearchWithCountryFirst() {
        let searchText = "US, Odessa"
        
        let filteredCities = sut.filter(cities: citiesMock, with: searchText)
        
        XCTAssertEqual(filteredCities.count, 0, "Found cities when search started with country")
    }
    
    func testSearchWithInvalidText() {
        let searchText = "alm"
        
        let filteredCities = sut.filter(cities: citiesMock, with: searchText)
        
        XCTAssertEqual(filteredCities.count, 0, "Found cities with incorrect search text")
    }
}
