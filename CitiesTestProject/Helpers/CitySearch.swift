//
//  CitySearch.swift
//  CitiesTestProject
//
//  Created by Dima Nikolaenko on 28.06.2020.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

protocol CitySearching {
    func filter(cities: [City], with searchedText: String) -> [City]
}

class CitySearch: CitySearching {
    func filter(cities: [City], with searchedText: String) -> [City] {
        let lowerBoundIndex = firstOccurrenceIndex(of: searchedText, from: 0, to: cities.count - 1, in: cities)
        guard lowerBoundIndex >= 0 else { return [] }
        let upperBoundIndex = lastOccurrenceIndex(of: searchedText, from: lowerBoundIndex, to: cities.count, in: cities)
        guard upperBoundIndex >= lowerBoundIndex, upperBoundIndex < cities.count else { return [] }
        
        return Array(cities[lowerBoundIndex...upperBoundIndex])
    }
    
    private func firstOccurrenceIndex(of searchText: String, from lowerBound: Int, to upperBound: Int, in cities: [City]) -> Int {
        guard lowerBound <= upperBound else { return -1 }
        
        let midIndex = (lowerBound + upperBound) / 2
        if cities[midIndex].searchName.lowercased().starts(with: searchText.lowercased()) && (midIndex == 0 || searchText.lowercased() > cities[midIndex - 1].searchName.lowercased()) {
            return midIndex
        } else if searchText.lowercased() > cities[midIndex].searchName.lowercased() {
            return firstOccurrenceIndex(of: searchText, from: midIndex + 1, to: upperBound, in: cities)
        } else {
            return firstOccurrenceIndex(of: searchText, from: lowerBound, to: midIndex - 1, in: cities)
        }
    }
    
    private func lastOccurrenceIndex(of searchText: String, from lowerBound: Int, to upperBound: Int, in cities: [City]) -> Int {
        guard lowerBound <= upperBound else { return -1 }
        
        let midIndex = (lowerBound + upperBound) / 2
        if cities[midIndex].searchName.lowercased().starts(with: searchText.lowercased()) && (midIndex == cities.count - 1 || searchText.lowercased() < cities[midIndex + 1].searchName.lowercased()) {
            return midIndex
        } else if searchText.lowercased() < cities[midIndex].searchName.lowercased() {
            return lastOccurrenceIndex(of: searchText, from: lowerBound, to: midIndex - 1, in: cities)
        } else {
            return lastOccurrenceIndex(of: searchText, from: midIndex + 1, to: upperBound, in: cities)
        }
    }
}
