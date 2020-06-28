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
        return cities.filter { $0.searchName.lowercased().starts(with: searchedText.lowercased()) }
    }
}
