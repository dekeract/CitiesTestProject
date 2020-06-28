//
//  City.swift
//  CitiesTestProject
//
//  Created by Dima Nikolaenko on 28.06.2020.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

struct City: Codable {
    var id: Int
    var name: String
    var country: String
    var coordinate: Coordinate
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name = "name"
        case country = "country"
        case coordinate = "coord"
    }
}
