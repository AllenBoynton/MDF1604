//
//  DogGroups.swift
//  ABoynton_CE4
//
//  Created by Allen Boynton on 4/13/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit


// Created class for plist data to view within the collection cells
class DogGroups {
    
    var name:  String?
    var group: String?
    
    // Initiators for cell label and group
    init(name: String, group: String) {
        self.name  = name
        self.group = group
    }
}
