//
//  CityLoader.swift
//  CitiesTestProject
//
//  Created by Dima Nikolaenko on 28.06.2020.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

protocol CityLoading {
    func load(_ completion: (Result<[City], Error>) -> Void)
}

class CityLoader: CityLoading {
    func load(_ completion: (Result<[City], Error>) -> Void) {
        
    }
}
