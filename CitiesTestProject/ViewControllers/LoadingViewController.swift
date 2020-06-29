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
                strongSelf.displayError(with: error.localizedDescription)
            }
            strongSelf.activityIndicator.stopAnimating()
        }
    }
    
    private func pushCitiesViewController(with cities: [City]) {
        guard let citiesViewController = UIStoryboard.cities.instantiateViewController(withIdentifier: self.citiesControllerIdentifier) as? CitiesViewController else { return }
        citiesViewController.cities = cities
        self.navigationController?.setViewControllers([citiesViewController], animated: true)
    }
    
    private func displayError(with message: String) {
        let alertController = UIAlertController(title: NSLocalizedString("city_alert_error_title", comment: ""), message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("city_alert_ok", comment: ""), style: .default, handler: { [weak self] _ in
            self?.pushCitiesViewController(with: [])
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
