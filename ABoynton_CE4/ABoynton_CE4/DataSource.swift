//
//  DataSource.swift
//  ABoynton_CE4
//
//  Created by Allen Boynton on 4/15/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit

// Populates data within arrays assigned in plist
class DataSource {
    
    init() {
        populateData()
    }
    
    // Delegate for DogGroup and creates property for both dogs & groups
    var dogs:[DogGroups] = []
    var groups:[String] = []
    
    // Determines how many cells in a sections
    func numberOfRowsInEachGroup(index: Int) -> Int {
        return dogsInGroup(index).count
    }
    
    // Determines how many sections
    func numberOfGroups() -> Int {
        return groups.count
    }
    
    // Fetch the group name
    func getGroupLabelAtIndex(index: Int) -> String {
        return groups[index]
    }
    
    // MARK: Populate Data from plist file
    
    func populateData() {
        
        // Accesses plist and pulls data then categorizes them
        if let path = NSBundle.mainBundle().pathForResource("DogData", ofType: "plist") {
            if let plistArray = NSArray(contentsOfFile: path) {
                for item in plistArray {
                    if let dictionary = item as? NSDictionary {
                        let name = dictionary["name"] as! String
                        let group = dictionary["group"] as! String
                        
                        // Assigns plist data with custom data source in DogGroups
                        let dog = DogGroups(name: name, group: group)
                        if !groups.contains(group) {
                            groups.append(group)
                        }
                        dogs.append(dog) // Adds each one
                    }
                }
            }
        }
    }
    
    // MARK: Assigns dogs in their groups
    
    func dogsInGroup(index: Int) -> [DogGroups] {
        let item = groups[index]
        let filteredDogs = dogs.filter { (dog: DogGroups) -> Bool in
            return dog.group == item
        }
        return filteredDogs
    }
}
