//
//  TableViewController.swift
//  UITableViews_Continued
//
//  Created by Allen Boynton on 4/9/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit

// MARK: Properties

// Private Global Constant Identifier
private let cellIdentifier = "myCell"
private let headerIdentifier = "myHeader"

class TableViewController: UITableViewController {
    
    // Data source file being accessed
    var vacations : [Vacations] = []
    var vacation2: [Vacations] = []
    
    
    let beachArray6 = Vacations(name: "Sunset Beach", image: UIImage(contentsOfFile: "oahu.jpg"), location: "Oahu, HI")
    let skiArray6   = Vacations(name: "Whistler Blackcomb", image: UIImage(contentsOfFile: "whistler.jpg"), location: "British Columbia, Canada")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Section 1
        
        // Get the images
        let beachImage1 = UIImage(named: "elnido.jpg")
        let beachImage2 = UIImage(named: "honokalani.jpg")
        let beachImage3 = UIImage(named: "pansyisland.jpg")
        let beachImage4 = UIImage(named: "anselazio.jpg")
        let beachImage5 = UIImage(named: "honopu.jpg")
        let beachImage6 = UIImage(named: "oahu.jpg")
        
        
        // Build the custom vacation objects
        let beachArray1 = Vacations(name: "El Nido", image: beachImage1, location: "Palawan, Philippines")
        let beachArray2 = Vacations(name: "Honokalani Beach", image: beachImage2, location: "Maui, HI")
        let beachArray3 = Vacations(name: "Pansy Island", image: beachImage3, location: "Archipelago, Mozambique")
        let beachArray4 = Vacations(name: "Anse Lazio", image: beachImage4, location: "Praslin, Seychelles")
        let beachArray5 = Vacations(name: "Honopu Beach", image: beachImage5, location: "Kauai, HI")
        let beachArray6 = Vacations(name: "Sunset Beach", image: beachImage6, location: "Oahu, HI")
        
        vacations = [beachArray1, beachArray2, beachArray3, beachArray4, beachArray5, beachArray6]
        
        
        // MARK: Section 2
        
        let skiImage1 = UIImage(named: "deervalleyresort.jpg")
        let skiImage2 = UIImage(named: "telluride.jpg")
        let skiImage3 = UIImage(named: "aspen.jpg")
        let skiImage4 = UIImage(named: "santafe.jpg")
        let skiImage5 = UIImage(named: "jackson.jpg")
        let skiImage6 = UIImage(named: "whistler.jpg")
        
        let skiArray1 = Vacations(name: "Deer Valley Resort", image: skiImage1, location: "Deer Valley, UT")
        let skiArray2 = Vacations(name: "Telluride Ski Resort", image: skiImage2, location: "Telluride, CO")
        let skiArray3 = Vacations(name: "Aspen Ski Resort", image: skiImage3, location: "Aspen Mountain, CO")
        let skiArray4 = Vacations(name: "Ski Santa Fe", image: skiImage4, location: "Santa Fe, NM")
        let skiArray5 = Vacations(name: "Snake River Lodge", image: skiImage5, location: "Jackson Hole, WY")
        let skiArray6 = Vacations(name: "Whistler Blackcomb", image: skiImage6, location: "British Columbia, Canada")
        
        vacation2 = [skiArray1, skiArray2, skiArray3, skiArray4, skiArray5, skiArray6]
        
        
        // Register .xib file to accept instructions within VC and tableView
        tableView.registerNib(UINib(nibName: "CustomHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: headerIdentifier)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the count of the arrays depending which section you are in
        if section == 0 {
            return vacations.count - 1
        }
        return vacation2.count
    }
    
    // Function deques the table cell as a template for the following cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Dequeue a reusable table cell as a template for the custom table cells
        let cell = tableView.dequeueReusableCellWithIdentifier (cellIdentifier, forIndexPath: indexPath) as! CustomTableViewCell
        
        // If statement determines which data is being sent to the corresponding section
        if indexPath.section == 0 {
            
            // Create constant that hold the value of
            let currentBeachSpot: Vacations = vacations[indexPath.row]
            
            // Configuring the cell row to display beach vacation data
            cell.vacationLabel1.text = currentBeachSpot.name
            cell.vacationImage.image = currentBeachSpot.image
            cell.vacationLabel2.text = currentBeachSpot.location
            
        } else {
            
            let currentSkiSpot: Vacations = vacation2[indexPath.row]
            
            // Configuring the cell row to display ski vacation data
            cell.vacationLabel1.text = currentSkiSpot.name
            cell.vacationImage.image = currentSkiSpot.image
            cell.vacationLabel2.text = currentSkiSpot.location
        }
        // Return data
        return cell
    }
    
    // Create an outlet to adjust height of header
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // Creater custom header using a custom header nib file
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(headerIdentifier) as! CustomHeader
        
        // Adjustments to custom header
        if section == 0 {
            header.sectionHeaderLabel.text = "Top Beaches"
        } else {
            header.sectionHeaderLabel.text = "Top Ski Resorts"
        }
        return header
    }
    
    // Opens/Closes editing the table view to delete cell row
    @IBAction func deleteButton(sender: UIButton) {
        tableView.editing = !tableView.editing
    }
    
    @IBAction func addButton(sender: UIButton) {
        let addVacation = beachArray6
        vacations.append(addVacation)
        tableView.reloadData()
        // Tried to do the if/else with section 0 and nothing worked
    }
    
    // Commit the act of being able to edit rows.....delete or insert
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        addAlert()
        if (editingStyle == .Delete) {
            if indexPath.section == 0 { // if/else to determine if we are working with section 1 or 2
                vacations.removeAtIndex(indexPath.row)
            } else {
                vacation2.removeAtIndex(indexPath.row)
            }
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    // Create Alert function
    func addAlert() {
        
        // Set up for alerting user to confirm deleting
        let alertController = UIAlertController(title: "Warning", message: "Do you want to delete location?", preferredStyle: .Alert)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (alertAction) -> Void in
            self.dismissViewControllerAnimated(false, completion: nil)
        }))
        
        alertController.addAction(UIAlertAction(title: "Delete", style: .Destructive, handler: { (alertAction) -> Void in
            
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
