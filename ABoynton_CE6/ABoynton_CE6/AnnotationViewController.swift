//
//  AnnotationViewController.swift
//  ABoynton_CE6
//
//  Created by Allen Boynton on 4/24/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AnnotationViewController: UIViewController, MKMapViewDelegate {
    
    // Protocol variables
    var locations: [Locations] = []
    var currentLocation: Locations? = nil
    
    // Outlets for map view for custom objects and image view
    @IBOutlet weak var mapView2: MKMapView!
    @IBOutlet weak var pointImage: UIImageView!
    
    // Location delegate initiated
    var locationManager2 = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // VC title
        self.title = currentLocation!.title
        
        // locationManager delegate created
        locationManager2.delegate = self
        
        // MARK: MKMapViewDelegate for annotations
        
        // Custom function to call annotations including custom action function
        // Setup up initial zoom and view
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: (currentLocation!.coordinate), span: span)
        
        // Formulates the map view
        mapView2.setRegion(region, animated: true)
        // Creates pin annotation location and titles
        let annotation = MKPointAnnotation()
        annotation.coordinate = (currentLocation!.coordinate)
        annotation.title = (currentLocation!.title)
        annotation.subtitle = (currentLocation!.subtitle)
        
        // Add annotations to map view
        mapView2.addAnnotation(annotation)
        
        // Custom image attributes
        pointImage.image = UIImage(named: currentLocation!.title!)
        pointImage.layer.cornerRadius = CGRectGetWidth(pointImage.frame)/6.0
        pointImage.clipsToBounds = true
        pointImage.layer.borderColor = UIColor.blackColor().CGColor
        pointImage.layer.borderWidth = 2
        pointImage.layer.cornerRadius = 6
    }
    
    // Customize the annotations
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var pinView = mapView2.dequeueReusableAnnotationViewWithIdentifier(pinIdentifier) as? MKPinAnnotationView
        
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

// MARK: CLLocationManagerDelegate
extension AnnotationViewController: CLLocationManagerDelegate {
    
    // Function gets user authorization for location access
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .NotDetermined {
            locationManager2.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        locationManager2.stopUpdatingLocation()
        print("ERROR: \(error)")
    }
    
    // Action function adds functionality to the segmented control for views
    @IBAction func mapViewControl(sender: UISegmentedControl) {
        // Switch statement for each segmented view
        switch (sender.selectedSegmentIndex) {
        case 0:
            mapView2.mapType = .Standard
        case 1:
            mapView2.mapType = .Satellite
        default:
            mapView2.mapType = .Hybrid
        }
    }
}
