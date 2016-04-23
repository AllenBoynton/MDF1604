//
//  MapViewController.swift
//  ABoynton_CE6
//
//  Created by Allen Boynton on 4/19/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

// Global identifiers
let cellIdentifier = "Cell"
let pinIdentifier = "Pin"


class MapViewController: UIViewController {
    
    var locations: [Locations] = []
    var currentPin: Locations?
    
    // Location delegate initiated
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pointImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // VC title
        self.title = currentPin!.title
        
        // locationManager delegate created
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
}

extension MapViewController: MKMapViewDelegate {
    
    override func viewWillAppear(animated: Bool) {
        getLocationData()
    }
    
    // MARK: MKMapViewDelegate
    
    // Custom function to call annotations including custom action function
    // Setup up initial zoom and view
    func getLocationData() {
        let centerCoordinate = currentPin!.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        
        // Formulates the map view
        mapView.setRegion(region, animated: true)
        
        // Creates pin annotation location and titles
        let annotation = MKPointAnnotation()
        annotation.coordinate = currentPin!.coordinate
        annotation.title = currentPin!.title
        annotation.subtitle = currentPin!.subtitle
        
        // Add annotations to map view
        mapView.addAnnotation(annotation)
        
        // Custom image attributes
        pointImage.image = UIImage(named: currentPin!.title!)
        pointImage.layer.cornerRadius = CGRectGetWidth(pointImage.frame)/6.0
        pointImage.clipsToBounds = true
        pointImage.layer.borderColor = UIColor.blackColor().CGColor
        pointImage.layer.borderWidth = 2
        pointImage.layer.cornerRadius = 6
        
        // Customize the annotations
        func customAnnotations() {
            func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
                if annotation.isMemberOfClass(MKUserLocation.self) {
                    return nil
                }
                
                var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(pinIdentifier) as? MKPinAnnotationView
                
                // Create if statement so identifier can recognize pin as a nil object and assign its values
                if pinView == nil {
                    pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinIdentifier)
                    
                    // Create animation & customization
                    pinView?.animatesDrop = true
                    pinView?.canShowCallout = true
                    pinView?.pinTintColor = UIColor.orangeColor()
                }
                return pinView
            }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    // MARK: Location Authorization
    
    // Function gets user authorization for location access
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let center = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: center.coordinate, span: span)
            
            mapView.setRegion(region, animated: true)
            print("Location: \(locations)")
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("ERROR: \(error)")
    }
    
    // Action function adds functionality to the segmented control for views
    @IBAction func mapViewControl(sender: UISegmentedControl) {
        // Switch statement for each segmented view
        switch (sender.selectedSegmentIndex) {
        case 0:
            mapView.mapType = .Standard
        case 1:
            mapView.mapType = .Satellite
        default:
            mapView.mapType = .Hybrid
        }
    }
    
    // MARK: CLLocationManagerDelegate
    
    // Swith to toggle the user's location on/off
    @IBAction func userLocationSwitch(sender: UISwitch) {
        if sender.on == true {
            locationManager.requestLocation()
            print("User location is turned ON")
        } else {
            locationManager.stopUpdatingLocation()
            print("User location is turned OFF")
        }
    }
}