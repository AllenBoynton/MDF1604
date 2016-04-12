//
//  MovieData.swift
//  CE1_UITableViews
//
//  Created by Allen Boynton on 4/6/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit

// Sub class that will hold the data within custom objects
struct MovieData {
    
    // Stored properties for view controller data
    var title: String
    var name:  String
    var date:  String
    var image: UIImage?
    
    // Init that allows the use of values to the stored properties
    init(title: String, name: String, date: String, image: UIImage?) {
        self.title = title
        self.name  = name
        self.date  = date
        self.image = image
    }
}