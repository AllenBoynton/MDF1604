//
//  MainViewController.swift
//  ABoynton_CE5
//
//  Created by Allen Boynton on 4/16/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit

// Global identifiers
let cellIdentifier = "Cell"
let toSearchSegue = "toSearch"

class MainViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display title of each VC
        navigationItem.title = "Results"

    }

    @IBAction func clearButton(sender: UIBarButtonItem) {
        
    }
}
