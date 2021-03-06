//
//  CityLoader.swift
//  CitiesTestProject
//
//  Created by Dima Nikolaenko on 28.06.2020.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

typealias LoadingCompletion = (Result<[City], Error>) -> Void

protocol CityLoading {
    func load(from fileName: String, completion: @escaping LoadingCompletion)
}

class CityLoader: CityLoading {
    private let queue = DispatchQueue(label: "personal.CitiesTestProject.CityLoader")
    
    func load(from fileName: String, completion: @escaping (Result<[City], Error>) -> Void) {
        let wrappedCompletion = wrapMainCompletion(completion)
        queue.async {
            guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
                wrappedCompletion(.failure(CityError.missingFile))
                return
            }
            
            do {
                let data = try Data(contentsOf: fileURL)
                var cities = try JSONDecoder().decode([City].self, from: data)
                cities.sort(by: { $0.searchName.lowercased() < $1.searchName.lowercased() })
                wrappedCompletion(.success(cities))
            } catch {
                wrappedCompletion(.failure(error))
            }
        }
    }
    
    private func wrapMainCompletion(_ completion: @escaping LoadingCompletion) -> LoadingCompletion {
      return { result in
        DispatchQueue.main.async {
          completion(result)
        }
      }
    }
}
