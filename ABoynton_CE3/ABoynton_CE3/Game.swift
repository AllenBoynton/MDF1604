//
//  Game.swift
//  ABoynton_CE3
//
//  Created by Allen Boynton on 4/13/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit

// Created simple protocol for the custom VC
struct Game {
    
    // 2 Stored properties
    var number: Int
    var place: String
    
    init(number: Int, place: String) {
        self.number = number
        self.place = place
    }
}
