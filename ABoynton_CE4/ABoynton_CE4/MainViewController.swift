//
//  MainViewController.swift
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

class MainViewController: UIViewController {
    
    // Stored properties passed in from class Datasource
    let dataSource = DataSource()
    
    // Outlet for the display of collectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
}

// MARK: CollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataSource.groups.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfRowsInEachGroup(section)
    }
    
    // MARK: Cell protocol
    
    // Create cell image and label with indexPath from CollectionViewCell by Datasource
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier,forIndexPath:indexPath) as! CollectionViewCell
        
        // Sourcing data from datasource within dogsingroup to isolate the name protocol
        let dogs: [DogGroups] = dataSource.dogsInGroup(indexPath.section)
        let dog = dogs[indexPath.row]
        
        let name = dog.name!
        
        // Displays name protocol to cell image and label
        cell.dogImageView.image = UIImage(named: name)
        cell.dogLabelView.text = name
        
        return cell
    }
    
    // MARK: Header protocol
    
    // Create view for header using supplementary view: CollectionReusableView
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier, forIndexPath: indexPath) as! CollectionReusableView
        
        // Sourcing data from datasource within dogsingroup to isolate the group protocol
        let dogs: [DogGroups] = dataSource.dogsInGroup(indexPath.section)
        let dog = dogs[indexPath.row]
        
        let group = dog.group!
        
        // Displays group protocol to header view label
        headerView.groupName.text = group
        headerView.deleteButton.tag = indexPath.section
        
        return headerView
    }
    
    // MARK: Delete controls
    
    // Action button for deleting sections
    @IBAction func deleteSection(sender: UIButton) {
        
        // Sections gets assigned a tag
        let section = sender.tag
        
        // Allows removal at sections
        dataSource.groups.removeAtIndex(section)
        
        // Allows deletion while updating .count of sections
        collectionView?.performBatchUpdates({ () -> Void in
            self.collectionView?.deleteSections(NSIndexSet(index: section))
            },
            completion: { (completed) -> Void in
                if completed {
                    self.collectionView?.reloadData()
                }
        })
    }
}
