//
//  DetailViewController.swift
//  CE1_UITableViews
//
//  Created by Allen Boynton on 4/6/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate {
    
    // Delegate to retrieve data from VC1
    var selectedMovie: MovieData? = nil
    
    // Outlets to display the given data
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var starringLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display title of each movie array in nav bar in VC2
        navigationItem.title = selectedMovie!.title
        
        // Display images and text for labels in the detailView
        imageView.image = selectedMovie!.image
        starringLabel.text = "Starring: \(selectedMovie!.name)"
        dateLabel.text = "Release Date: \(selectedMovie!.date)"
    }
}
