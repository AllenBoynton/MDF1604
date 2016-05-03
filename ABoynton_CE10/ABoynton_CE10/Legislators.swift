//
//  Legislators.swift
//  ABoynton_CE10
//
//  Created by Allen Boynton on 4/28/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit


// full name, bioguide_id, state, title, and party
class Legislators {
    
    var name : String
    var image: UIImage?
    var state: String
    var title: String
    var party: String
    
    init(name: String, image: UIImage?, state: String, title: String, party: String) {
        
        self.name  = name
        self.image = image
        self.state = state
        self.title = title
        self.party = party
        
    }
    
}
