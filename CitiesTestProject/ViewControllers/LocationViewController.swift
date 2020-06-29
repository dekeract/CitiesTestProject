//
//  LocationViewController.swift
//  CitiesTestProject
//
//  Created by Dima Nikolaenko on 28.06.2020.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController {
    @IBOutlet weak var mapKitView: MKMapView!
    
    var coordinate: Coordinate?
    
    private let regionDistance = 3000.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let coordinate2D = self.coordinate?.toCoordinate2D() else { return }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate2D
        mapKitView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: coordinate2D, latitudinalMeters: self.regionDistance, longitudinalMeters: self.regionDistance)
        mapKitView.setRegion(region, animated: false)
    }
}
