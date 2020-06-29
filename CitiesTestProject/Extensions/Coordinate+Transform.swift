//
//  Coordinate+Transform.swift
//  CitiesTestProject
//
//  Created by Dima Nikolaenko on 29.06.2020.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import CoreLocation

extension Coordinate {
    func toCoordinate2D() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}
