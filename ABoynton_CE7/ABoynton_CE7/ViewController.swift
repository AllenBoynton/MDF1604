//
//  ViewController.swift
//  ABoynton_CE7
//
//  Created by Allen Boynton on 4/24/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController {
    
    // Gives access to the event store
    let eventStore = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Find current status with events
        let status = EKEventStore.authorizationStatusForEntityType(.Event)
        
        if status == .NotDetermined {
            eventStore.requestAccessToEntityType(.Event, completion: { (granted, error) in
                if error == error {
                    print("Request FAILED with error: \(error)")
                    return
                }
                
                if granted {
                    print("Granted Access")
                } else {
                    // Disable some funtionality - dispatch asynchronously
                    print("Denied Access")
                }
            })
        }
    }
    
    @IBAction func newCalendar(sender: AnyObject) {
    }
    
}

