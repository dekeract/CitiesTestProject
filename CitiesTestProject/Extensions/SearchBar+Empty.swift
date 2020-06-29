//
//  SearchBar+Empty.swift
//  CitiesTestProject
//
//  Created by Dima Nikolaenko on 29.06.2020.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

extension UISearchBar {
    var isEmpty: Bool {
        return self.text?.isEmpty ?? true
    }
}
