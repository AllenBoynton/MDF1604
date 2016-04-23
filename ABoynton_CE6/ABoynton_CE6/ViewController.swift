//
//  ViewController.swift
//  ABoynton_CE6
//
//  Created by Allen Boynton on 4/19/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController {
    
    var locations: [Locations] = []
    var currentPin: Locations?
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var usersLocationData: UILabel!
    @IBOutlet weak var xImage: UIImageView!
    @IBOutlet weak var checkMarkImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display title of each VC
        navigationItem.title = "Map Menu"
        
        usersLocationData.text = ""
        getLocations()
    }
    
    // Add # of rows to table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    // locations array data passed to prototype table view cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        let location: Locations = locations[indexPath.row]
        cell.textLabel!.text = location.title
        cell.detailTextLabel!.text = location.subtitle
        
        return cell
    }
    
    // Function connects segue from my MapViewController to my TableViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailView: MapViewController = segue.destinationViewController as! MapViewController
        let indexPath: NSIndexPath? = tableView.indexPathForSelectedRow
        let currentPin: Locations = locations[indexPath!.row]
        
        detailView.currentPin = currentPin
    }

    // location custom data
    func getLocations() {
        locations = [
            Locations(title: "Downtown Greenville, SC", subtitle: "Hopping S.Main St.", coordinate: CLLocationCoordinate2D(latitude: 34.8495, longitude: -82.3995)),
            Locations(title: "Lakeside Place Homes", subtitle: "Where I call home!", coordinate: CLLocationCoordinate2D(latitude: 34.862234, longitude: -82.353301)),
            Locations(title: "Falls Park on the Reedy", subtitle: "Beautiful waterfall park!", coordinate: CLLocationCoordinate2D(latitude: 34.84421, longitude: -82.401505)),
            Locations(title: "iStore", subtitle: "Independently owned Apple store", coordinate: CLLocationCoordinate2D(latitude: 34.848191, longitude: -82.400572)),
            Locations(title: "Bon Secours Wellness Arena", subtitle: "Large events arena", coordinate: CLLocationCoordinate2D(latitude: 34.852476, longitude: -82.391517)),
            Locations(title: "Larkin's on the River", subtitle: "My favorite restaurant!", coordinate: CLLocationCoordinate2D(latitude: 34.8465, longitude: -82.401581)),
            Locations(title: "Nexsen Pruet Law Firm", subtitle: "This is where my fiance works!", coordinate: CLLocationCoordinate2D(latitude: 34.845051, longitude: -82.399741)),
        ]
    }
    
    // Switch that removes annotations
    @IBAction func showAnnotations(sender: UISwitch) {
        if (sender.on) {
            // Switch is ON
//            self.maps.viewForAnnotation(annotation)?.hidden = false
            print("Annotation switch is ON")
        } else {
            // Switch is OFF
//            self.maps.viewForAnnotation(annotation)?.hidden = true
            print("Annotation switch is OFF")
        }
    }
}

