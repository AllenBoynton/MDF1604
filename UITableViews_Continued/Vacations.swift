//
//  Vacations.swift
//  UITableViews_Continued
//
//  Created by Allen Boynton on 4/9/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit

struct Vacations {
    
    // Stored properties for view controller data
    var name: String
    var image: UIImage?
    var location: String
    
    // Init that allows the use of values to the stored properties
    init(name: String, image: UIImage?, location: String) {
        self.name = name
        self.image = image
        self.location = location
    }
}
