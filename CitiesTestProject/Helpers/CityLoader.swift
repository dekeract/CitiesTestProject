//
//  CityLoader.swift
//  CitiesTestProject
//
//  Created by Dima Nikolaenko on 28.06.2020.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

protocol CityLoading {
    func load(from fileName: String, completion: @escaping (Result<[City], Error>) -> Void)
}

class CityLoader: CityLoading {
    private let queue = DispatchQueue(label: "personal.CitiesTestProject.CityLoader")
    
    func load(from fileName: String, completion: @escaping (Result<[City], Error>) -> Void) {
        queue.async {
            guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
                completion(.failure(CityError.missingFile))
                return
            }
            
            do {
                let data = try Data(contentsOf: fileURL)
                var cities = try JSONDecoder().decode([City].self, from: data)
                cities.sort(by: { $0.searchName < $1.searchName })
                completion(.success(cities))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
