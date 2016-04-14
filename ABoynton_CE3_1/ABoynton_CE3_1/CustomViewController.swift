//
//  CustomViewController.swift
//  ABoynton_CE3
//
//  Created by Allen Boynton on 4/13/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {
    
    // MARK: Properties
    
    // Stored properties passed in from the struct Game
    var game: [Game] = []
    
    // Local Variables
    var quantity: Int = 0
    var location: String = ""
    
    // Outlets for displayed labels and fields
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var animalText: UITextField!
    @IBOutlet weak var verbText: UITextField!
    @IBOutlet weak var objectText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use of custom object protocol for use in the labelView
        let animalData = Game(number: 33, place: "Buenos Aires")
        
        // Created variables to hold values of custom object protocol
        quantity = animalData.number
        location = animalData.place
        
    }
    
    // Created button to populate a concatenated string of custom objects and user input
    @IBAction func createButton(sender: UIButton) {
        completeText()
        labelView.text = "The \(quantity) rabid \(animalText.text!)s had to run and \(verbText.text!) through the streets of \(location), to chase the \(objectText.text!)!"
        
    }
    
    // Function creates an alert to verify all user text fields are completed by the user
    func completeText() -> Bool {
        if animalText!.text == "" || verbText!.text == "" || objectText!.text == "" {
            
            let alertUser = UIAlertController(title: "Alert", message: "Please complete all fields to continue", preferredStyle: UIAlertControllerStyle.Alert)
            
            let acceptButton = UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil)
            
            alertUser.addAction(acceptButton)
            
            presentViewController(alertUser, animated: true, completion: nil) // Presents the alert to the user
            
            return false
        }
        return true
    }
    
    // MARK: Keyboard functions
    
    // Next buttons will advance to the next field
    // Return button (Done) will dismiss keyboard for completion of textField6
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == animalText {
            verbText.becomeFirstResponder()
        }
        if textField == verbText {
            objectText.becomeFirstResponder()
        } else {
            objectText.resignFirstResponder() // dissmisses keyboard
        }
        return true
    }
    
    // Removes keyboard when tapping view
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}
