//
//  EventsViewController.swift
//  ABoynton_CE7.1
//
//  Created by Allen Boynton on 4/24/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit
import EventKit


class EventsViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Events"
        
        // Create authorization status
        let status = EKEventStore.authorizationStatusForEntityType(.Reminder)
        
        if status == .NotDetermined {
            // Request access to calendars
            Global.eventStore.requestAccessToEntityType(.Reminder, completion: { (granted, error) -> Void in
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
    }
    
    @IBAction func createEvent(sender: UIButton) {
        let event = EKEvent(eventStore: Global.eventStore)
        
        event.title = "Week 23 Review"
        event.startDate = NSDate()
        event.endDate = event.startDate.dateByAddingTimeInterval(3600)
        
        // Save to 
        event.calendar = Cal.newCalendar
        
        // Save the event
        do {
            try Global.eventStore.saveEvent(event, span: .ThisEvent, commit: true)
        } catch {
            print(error)
        }
    }
    
    @IBAction func createReminder(sender: UIButton) {
        // Check the status
        
        let reminder = EKReminder(eventStore: Global.eventStore)
        
        reminder.title = "Pregnancy Reminders"
        reminder.startDateComponents = NSCalendar.currentCalendar().components([.Month, .Day, .Year], fromDate: NSDate())
        
        reminder.calendar = Cal.newCalendar
        
        // Save calendar to the database
        do {
            try Global.eventStore.saveReminder(reminder, commit: true)
        } catch let error as NSError {
            print(error)
        }
    }
}
