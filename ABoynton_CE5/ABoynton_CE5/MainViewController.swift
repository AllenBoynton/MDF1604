//
//  MainViewController.swift
//  ABoynton_CE5
//
//  Created by Allen Boynton on 4/15/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit

// Global identifiers
let cellIdentifier = "Cell"
let searchSegue = "toSearch"
let detailSegue = "toDetails"

class MainViewController: UIViewController {
    
    @IBOutlet weak var savedData: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display title of each VC
        navigationItem.title = "Results"
    }
    
    // Take saved data and display it
    @IBAction func editedSaveAndReturn(segue: UIStoryboardSegue) {
        //        let source = segue.sourceViewController as! SearchViewController
        
        // Assign new edited value to labels in VC1
        //        savedData.text = source.tableView?.text!
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // Clears text in text view
    @IBAction func clearButton(sender: UIBarButtonItem) {
        
        
    }
}
