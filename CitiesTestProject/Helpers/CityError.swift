//
//  CityError.swift
//  CitiesTestProject
//
//  Created by Dima Nikolaenko on 28.06.2020.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

enum CityError: Error, LocalizedError {
    case missingFile
    
    var errorDescription: String? {
        switch self {
        case .missingFile:
            return NSLocalizedString("city_missing_file_error", comment: "")
        }
    }
}

