//
//  City+Search.swift
//  CitiesTestProject
//
//  Created by Dima Nikolaenko on 28.06.2020.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

extension City {
    var searchName: String {
        return String(format: "%@, %@", self.name, self.country)
    }
}
