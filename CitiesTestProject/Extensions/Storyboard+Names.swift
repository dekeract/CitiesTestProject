//
//  Storyboard+Names.swift
//  CitiesTestProject
//
//  Created by Dima Nikolaenko on 29.06.2020.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static var cities: UIStoryboard {
        return UIStoryboard(name: "Cities", bundle: Bundle.main)
    }
}
