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
    private var filteredCities: [City] = []
    
    private var items: [City] {
        return self.isFiltering ? self.filteredCities : self.cities
    }
    
    private let citiesFilename = "cities"
    private let cellIdentifier = "Cell"
    private let segueIdentifier = "LocationSegue"
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var isFiltering: Bool {
        return self.searchController.isActive && !self.searchController.searchBar.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = NSLocalizedString("city_search_bar_placeholder", comment: "")
        self.navigationItem.searchController = self.searchController
        self.definesPresentationContext = true
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == self.segueIdentifier else { return }
        
        guard let senderCell = sender as? UITableViewCell else { return }
        
        guard let indexPath = self.citiesTableView.indexPath(for: senderCell) else { return }
        
        guard let locationViewController = segue.destination as? LocationViewController else { return }
        
        locationViewController.coordinate = self.items[indexPath.row].coordinate
    }
}

extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        let city = self.items[indexPath.row]
        cell.textLabel?.text = city.searchName
        cell.detailTextLabel?.numberOfLines = 2
        cell.detailTextLabel?.text = city.coordinateString
        return cell
    }
}

extension CitiesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            self.citiesTableView.reloadData()
            return
        }
        
        self.filteredCities = self.search.filter(cities: self.cities, with: searchText)
        self.citiesTableView.reloadData()
    }
}

