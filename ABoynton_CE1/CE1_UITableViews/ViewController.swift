//
//  ViewController.swift
//  CE1_UITableViews
//
//  Created by Allen Boynton on 4/6/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit

// MARK: Properties

// Private Global Constant Identifier
private let cellIdentifier = "myCell"
private let segueIdentifier = "toDetailVC"

class ViewController: UIViewController, UITableViewDataSource {
    
    // Array holds all movie data
    var movieArrays: [MovieData] = []
    
    // Connects table view to code
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Build the custom movie objects
    let movieArray = [
        MovieData(title: "Batman v Superman", name: "Ben Affleck & Henry Cavill", date: "March 25, 2016"),
        MovieData(title: "Zootopia", name: "Ginnifer Goodwin & Jason Bateman", date: "March 4, 2016"),
        MovieData(title: "My Big Fat Greek Wedding 2", name: "Nia Varalos & John Corbett", date: "March 25, 2016"),
        MovieData(title: "God's Not Dead 2", name: "Melissa Joan Hart & Jesse Metcalfe", date: "April 1, 2016"),
        MovieData(title: "Miracles from Heaven", name: "Jennifer Garner", date: "March 16, 2016")
    ]
    
    // MARK: Table view data source
    
    // Creates the proper number of cells by the amount of array elements
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    // Function deques the table cell as a template for the following cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Dequeue a reusable table cell as a template for the following cell rows
        let cell = tableView.dequeueReusableCellWithIdentifier (cellIdentifier, forIndexPath: indexPath)
        // Create constant that hold the value of
        let currentMovie: MovieData = movieArray[indexPath.row]
        // Configuring the cell row to display movie title
        cell.textLabel?.text = currentMovie.title
        // Return data
        return cell
    }
    
    // Passing data
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Accessing segue by calling the segue identifier
        if segue.identifier == segueIdentifier {
            // Creating my destination assignment for where I want my data to go
            let destination = segue.destinationViewController as! DetailViewController
            // All important indexPath to access the table cells
            if let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell) {
                // Sending data to my selectedMovie
                destination.selectedMovie = movieArray[indexPath.row]
            }
        }
    }
}
