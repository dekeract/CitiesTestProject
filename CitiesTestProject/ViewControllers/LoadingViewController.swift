//
//  LoadingViewController.swift
//  CitiesTestProject
//
//  Created by Dima Nikolaenko on 29.06.2020.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let loader: CityLoader = CityLoader()
    private let citiesFilename = "cities"
    private let citiesControllerIdentifier = "CitiesViewController"
    
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
                strongSelf.pushCitiesViewController(with: items)
            case .failure(let error):
                // TODO: Display error
                break
            }
            strongSelf.activityIndicator.stopAnimating()
        }
    }
    
    private func pushCitiesViewController(with cities: [City]) {
        guard let citiesViewController = UIStoryboard.cities.instantiateViewController(withIdentifier: self.citiesControllerIdentifier) as? CitiesViewController else { return }
        citiesViewController.cities = cities
        self.navigationController?.setViewControllers([citiesViewController], animated: true)
    }
}
