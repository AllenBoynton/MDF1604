//
//  DogGroups.swift
//  ABoynton_CE4
//
//  Created by Allen Boynton on 4/13/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit


// Created class for label and image view within the collection cells
class DogGroups {
    
    var dog: String
    var image: UIImage?
    
    // Initiators for cell label and image
    init(dog: String, image: UIImage?) {
        self.dog = dog
        self.image = image
    }
    
}
