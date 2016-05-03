//
//  CalendarViewController.swift
//  ABoynton_CE7.1
//
//  Created by Allen Boynton on 4/24/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit
import EventKit


// Global Initializers
let eventsVC = "toSecondVC"


class CalendarViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Calendar"
        
        // Create authorization status
        let status = EKEventStore.authorizationStatusForEntityType(.Event)
        
        if status == .NotDetermined {
            // Request access to calendars
            Global.eventStore.requestAccessToEntityType(.Event, completion: { (granted, error) -> Void in
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
        
        Cal.newCalendar = EKCalendar(forEntityType: .Event, eventStore: Global.eventStore)
        
        // Configure
        Cal.newCalendar.title = "Pregnancy Calendar"
        Cal.newCalendar.CGColor = UIColor.cyanColor().CGColor
        
        for source in Global.eventStore.sources {
            
            // Find local source
            if source.sourceType == EKSourceType.Local {
                Cal.newCalendar.source = source
                break
            }
        }
        
        // Save calendar to the database
        do {
            try Global.eventStore.saveCalendar(Cal.newCalendar, commit: true)
        } catch let error as NSError {
            print(error)
        }
    }
}


    



