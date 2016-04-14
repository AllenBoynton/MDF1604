//
//  NavViewController.swift
//  ABoynton_CE3
//
//  Created by Allen Boynton on 4/13/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit

// VC created only to hold the popToRoot function for home button
class NavViewController: UIViewController, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // IBAction button to return to home page
    @IBAction func goHome(sender: UIButton) {
        // Used the pop to root to use button to bring the user to the root VC
        navigationController!.popToRootViewControllerAnimated(true)
    }
}
