//
//  City+DisplayCoordinate.swift
//  CitiesTestProject
//
//  Created by Dima Nikolaenko on 29.06.2020.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

extension City {
    var coordinateString: String {
        return String(format: "Lat: %d, \nLon: %d", self.coordinate.latitude, self.coordinate.longitude)
    }
}
