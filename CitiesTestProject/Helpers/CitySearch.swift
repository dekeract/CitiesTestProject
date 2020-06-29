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
        // filter is based on binary search algorithm with time complexity O(Logn)
        // at first we find the first occurrence index of city name with searched text prefix, from 0 to end of array
        let lowerBoundIndex = firstOccurrenceIndex(of: searchedText, from: 0, to: cities.count - 1, in: cities)
        guard lowerBoundIndex >= 0 else { return [] }
        // then we find the last occurrence index of city name with searched text prefix, but in this case from first occurrence index to end of array
        let upperBoundIndex = lastOccurrenceIndex(of: searchedText, from: lowerBoundIndex, to: cities.count, in: cities)
        guard upperBoundIndex >= lowerBoundIndex, upperBoundIndex < cities.count else { return [] }
        
        // return cities between first occurrence index and last one
        return Array(cities[lowerBoundIndex...upperBoundIndex])
    }
    
    private func firstOccurrenceIndex(of searchText: String, from lowerBound: Int, to upperBound: Int, in cities: [City]) -> Int {
        guard lowerBound <= upperBound else { return -1 }
        
        // find middle index of an array
        let midIndex = (lowerBound + upperBound) / 2
        // idea is to find if middle city name (MC) matches the prefix
        // if it does, we get the prev to middle city (PC) and match it's name with the prefix
        // if it's bigger, than any city name prev to MC doesn't match the prefix
        // because in order to match the prefix city name should contain the prefix characters + some else's
        // but in that case the prefix always be less than PC name
        // check midIndex == 0 is for safety to know that we don't go out of array
        if cities[midIndex].searchName.lowercased().starts(with: searchText.lowercased()) && (midIndex == 0 || searchText.lowercased() > cities[midIndex - 1].searchName.lowercased()) {
            return midIndex
        } else if searchText.lowercased() > cities[midIndex].searchName.lowercased() {
            // so, if MC doesn't match the prefix, but the prefix is bigger than MC, we get the right half of array and call firstOccurrenceIndex on it
            return firstOccurrenceIndex(of: searchText, from: midIndex + 1, to: upperBound, in: cities)
        } else {
            // if MC doesn't match the prefix or the prefix is less than MC, we get the left half and call firstOccurrenceIndex on it
            // because if the prefix is less (doesn't matter if it MC matched the prefix or not), it means that it's a first occurrence index
            return firstOccurrenceIndex(of: searchText, from: lowerBound, to: midIndex - 1, in: cities)
        }
    }
    
    private func lastOccurrenceIndex(of searchText: String, from lowerBound: Int, to upperBound: Int, in cities: [City]) -> Int {
        guard lowerBound <= upperBound else { return -1 }
        
        // idea is same as for firstOccurrenceIndex, just we are looking for last one
        // for this we reverse logic of firstOccurrenceIndex
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
