//
//  Locations.swift
//  ABoynton_CE6
//
//  Created by Allen Boynton on 4/19/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit
import MapKit


class Locations {
    
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
    }
}