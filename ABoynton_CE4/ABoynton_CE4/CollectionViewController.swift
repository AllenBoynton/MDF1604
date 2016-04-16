//
//  CollectionViewController.swift
//  ABoynton_CE4
//
//  Created by Allen Boynton on 4/13/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit

// MARK: Properties

// Global identifier
private let cellIdentifier = "Cell"
private let headerIdentifier = "Header"

class CollectionViewController: UICollectionViewController {
    
    // Stored properties passed in from class DogGroups
    var dogGroups: [DogGroups] = []
    
    var sportArray = []
    var workArray = []
    var toyArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sporting group array
        let sportArray1 = DogGroups(dog: "Brittany", image: UIImage(named: "brittany.jpg"))
        let sportArray2 = DogGroups(dog: "Chesapeake Bay Retiever", image: UIImage(named: "chesapeakebay.jpg"))
        let sportArray3 = DogGroups(dog: "Cocker Spaniel", image: UIImage(named: "cocker.jpg"))
        let sportArray4 = DogGroups(dog: "Golden Retriever", image: UIImage(named: "goldenret.jpg"))
        let sportArray5 = DogGroups(dog: "Irish Setter", image: UIImage(named: "IrishSetter.jpg"))
        let sportArray6 = DogGroups(dog: "Labrador Retiever", image: UIImage(named: "lab.jpg"))
        
        // Working group array
        let workArray1 = DogGroups(dog: "Alaskan Malamute", image: UIImage(named: "alaskanMalamute.jpg"))
        let workArray2 = DogGroups(dog: "Boerboel", image: UIImage(named: "boerboel.jpg"))
        let workArray3 = DogGroups(dog: "Boxer", image: UIImage(named: "boxer.jpg"))
        let workArray4 = DogGroups(dog: "Cane Corso", image: UIImage(named: "CaneCorso.jpg"))
        let workArray5 = DogGroups(dog: "Doberman Pinscher", image: UIImage(named: "doberman.jpg"))
        let workArray6 = DogGroups(dog: "Rottweiler", image: UIImage(named: "rottweiler.jpg"))
        
        // Toy group array
        let toyArray1 = DogGroups(dog: "Chihuahua", image: UIImage(named: "chihuahua.jpg"))
        let toyArray2 = DogGroups(dog: "Italian Greyhound", image: UIImage(named: "italianGreyhound.jpg"))
        let toyArray3 = DogGroups(dog: "Maltese", image: UIImage(named: "maltese.jpg"))
        let toyArray4 = DogGroups(dog: "Miniature Pinscher", image: UIImage(named: "minpin.jpg"))
        let toyArray5 = DogGroups(dog: "Pomeranian", image: UIImage(named: "pomeranian.jpg"))
        let toyArray6 = DogGroups(dog: "Pug", image: UIImage(named: "pug.jpg"))
        
        // Custome object arrays
        sportArray = [sportArray1, sportArray2, sportArray3, sportArray4, sportArray5, sportArray6]
        workArray = [workArray1, workArray2, workArray3, workArray4, workArray5, workArray6]
        toyArray = [toyArray1, toyArray2, toyArray3, toyArray4, toyArray5, toyArray6]
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Returning the count of the arrays depending which section you are in
        if section == 0 {
            return sportArray.count
        } else if section == 1 {
            return workArray.count
        } else {
            return toyArray.count
        }
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        
        // If statement determines which data is being sent to the corresponding section
        if indexPath.section == 0 {
            
            // Create constant that holds the value of sportArray
            let currentSportDog = sportArray[indexPath.row] as! DogGroups
            
            // Configuring the collection cell row to display dog data
            cell.dogImageView.image = currentSportDog.image
            cell.dogLabelView.text = currentSportDog.dog
            
        } else  if indexPath.section == 1 {
            
            // Create constant that hold the value of workArray
            let currentWorkDog = workArray[indexPath.row] as! DogGroups
            
            // Configuring the collection cell row to display dog data
            cell.dogImageView.image = currentWorkDog.image
            cell.dogLabelView.text = currentWorkDog.dog
            
        } else {
            
            // Create constant that hold the value of toyArray
            let currentToyDog = toyArray[indexPath.row] as! DogGroups
            
            // Configuring the collection cell row to display dog data
            cell.dogImageView.image = currentToyDog.image
            cell.dogLabelView.text = currentToyDog.dog
            
        }
        return cell
    }
    
    // Create view for header
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier, forIndexPath: indexPath) as! CollectionReusableView
        
        // Using an if/else to designate between sections
        if indexPath == 0 {
            headerView.groupName.text = "Sporting Group"
        } else if indexPath == 1 {
            headerView.groupName.text = "Working Group"
        } else {
            headerView.groupName.text = "Toy Group"
        }
        return headerView
    }
    
    // Action button for deleting sections
    @IBAction func deleteButton(sender: UIButton) {
        
        
    }
}
