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
let segueIdentifier = "toAnnotation"
let secondVC = "toSecond"
let pinIdentifier = "Pin"

class MapViewController: UIViewController {
    
    // Protocol variables
    var locations: [Locations] = []
    var currentLocation: Locations? = nil
    
    // Location delegate initiated
    var locationManager = CLLocationManager()
    var place: String = ""
    
    // Outlet to user location map
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // VC title
        self.title = "Map"
        
        // Creating map delegate
        locationManager.delegate = self
    }
    
    @IBAction func unwindToRootVC(segue: UIStoryboardSegue) {}
}

extension MapViewController: CLLocationManagerDelegate {
    
    // MARK: Location Authorization
    // MARK: CLLocationManagerDelegate
    
    // Function gets user authorization for location access
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue: CLLocationCoordinate2D = manager.location!.coordinate
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        
        place = "London, England: \(locations)"
        
        shouldPerformSegueWithIdentifier(secondVC, sender: self)

        print("Location: London, England: \(locations)")
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        locationManager.stopUpdatingLocation()
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
    
    // Swith to toggle the user's location on/off
    @IBAction func userLocationSwitch(sender: UISwitch) {
        if sender.on == true {
            mapView.showsUserLocation = true
            locationManager.requestLocation()
            
            shouldPerformSegueWithIdentifier(secondVC, sender: sender)
            print("User location is turned ON.")
            
        } else {
            mapView.showsUserLocation = false
            locationManager.stopUpdatingLocation()
            print("User location is turned OFF.")
        }
    }
    
    // Function connects segue from my MapViewController to my ViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! ViewController
        destination.userStatus = mapView.showsUserLocation
        destination.currentLocation = place
    }
}