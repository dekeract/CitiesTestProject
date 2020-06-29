//
//  CitiesViewController.swift
//  CitiesTestProject
//
//  Created by Dima Nikolaenko on 28.06.2020.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {
    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private let loader: CityLoader = CityLoader()
    private let search: CitySearch = CitySearch()
    
    private var cities: [City] = []
    
    private let citiesFilename = "cities"
    private let cellIdentifier = "Cell"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.activityIndicator.startAnimating()
        self.loader.load(from: self.citiesFilename) { [weak self] (result) in
            guard let strongSelf = self else {
                self?.activityIndicator.stopAnimating()
                return
            }
            
            switch result {
            case .success(let items):
                strongSelf.cities = items
                strongSelf.citiesTableView.reloadData()
            case .failure(let error):
                // TODO: Display error
                break
            }
            strongSelf.activityIndicator.stopAnimating()
        }
    }
}

extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        let city = self.cities[indexPath.row]
        cell.textLabel?.text = city.searchName
        cell.detailTextLabel?.numberOfLines = 2
        cell.detailTextLabel?.text = city.coordinateString
        return cell
    }
}

