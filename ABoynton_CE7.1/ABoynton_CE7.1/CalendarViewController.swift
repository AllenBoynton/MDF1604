//
//  ViewController.swift
//  ABoynton_CE7.1
//
//  Created by Allen Boynton on 4/27/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit
import EventKit

// Global Initializers
let eventsVC = "toSecondVC"

class ViewController: UIViewController {
    
    // Event store delegate
    let eventStore = EKEventStore()
    var calendar = EKCalendar()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Calendar"
        
        // Create authorization status
        let status = EKEventStore.authorizationStatusForEntityType(.Event)
        
        if status == .NotDetermined {
            // Request access to calendars
            eventStore.requestAccessToEntityType(.Event, completion: { (granted, error) -> Void in
                if error == error {
                    print("Request FAILED with ERROR \(error)")
                    return
                }
                
                if granted {
                    print("Granted Access")
                } else {
                    // Disable some UI
                    print("Denied")
                }
            })
        }

        // Area where you want to handle other situations
    }

    @IBAction func createCalendar(sender: UIButton) {
        // Check the status
        
        calendar = EKCalendar(forEntityType: .Event, eventStore: eventStore)
        
        // Configure 
        calendar.title = "Pregnancy Calendar"
        calendar.CGColor = UIColor.cyanColor().CGColor
        
        shouldPerformSegueWithIdentifier(eventsVC, sender: sender)
        
        for source in eventStore.sources {
            
            // Find local source
            if source.sourceType == EKSourceType.Local {
                calendar.source = source
                break
            }
        }
        
        // Save calendar to the database
        do {
            try eventStore.saveCalendar(calendar, commit: true)
        } catch let error as NSError {
            print(error)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == eventsVC {
            if let destination = segue.destinationViewController as? EventsViewController {
                destination.calendar = calendar
            }
        }
    }
}


