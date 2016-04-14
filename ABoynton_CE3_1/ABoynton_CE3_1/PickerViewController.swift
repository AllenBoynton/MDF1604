//
//  PickerViewController.swift
//  ABoynton_CE3
//
//  Created by Allen Boynton on 4/13/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit

// Made use of both the picker data sorce and delegate
class PickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Outlets for the main label and picker itself
    @IBOutlet weak var pickerLabel: UILabel!
    @IBOutlet weak var dogPicker: UIPickerView!
    
    // My custom array source
    var dogArray = ["My dog Bella", "Alaskan Malamute", "Boerboel", "Boxer", "Chesapeake Bay Retriever",
                "Chihuahua", "Golden Retriever", "Italian Greyhound", "Labrador Retriever", "Miniature Pinscher"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Determine how many components in the picker
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Determine how many rows in the component
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dogArray.count
    }

    // Sets the picker to take a string value given a title
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dogArray[row]
    }
    
    // Adds each index of the array to each picker row
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerLabel.text = dogArray[row]
    }
    
    // Toggles picker view on/off
    @IBAction func pickerToggle(sender: UIButton) {
        dogPicker.hidden = !dogPicker.hidden
    }
}
