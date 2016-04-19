//
//  DetailViewController.swift
//  ABoynton_CE5
//
//  Created by Allen Boynton on 4/16/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit

// I know I did not have to do this but I already -
// started a segue, so figured it wouldn't take long
class DetailViewController: UIViewController {
    
    // Outlets for the label & image of dog
    @IBOutlet weak var dogName: UILabel!
    @IBOutlet weak var dogImage: UIImageView!
    
    // DataSource for details in this VC
    var dogDetail: SearchItems? {
        didSet {
            configureView()
        }
    }
    
    // Assigns the segue delegate to the labels and image of VC3
    func configureView() {
        if let dogDetail = dogDetail {
            if let dogName = dogName, dogImage = dogImage {
                dogName.text = dogDetail.name
                dogImage.image = UIImage(named: dogDetail.name)
                title = dogDetail.group
            }
        }
    }
    
    // Function is called to display the configure view
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}
