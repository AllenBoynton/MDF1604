//
//  ViewController.swift
//  EditEvents
//
//  Created by Allen Boynton on 4/27/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit
import EventKit
import EventKitUI

class ViewController: UIViewController, EKCalendarChooserDelegate, EKEventEditViewDelegate {
    
    // Event store delegate
    let eventStore = EKEventStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
    @IBAction func displayChooser(sender: UIButton) {
        let chooser = EKCalendarChooser(selectionStyle: .Single, displayStyle: .AllCalendars, entityType: .Event, eventStore: eventStore)
        
        chooser.showsCancelButton = true
        chooser.showsDoneButton = true
        chooser.delegate = self
        
        let nav = UINavigationController(rootViewController: chooser)
        nav.hidesBarsWhenKeyboardAppears = true
        
        presentViewController(nav, animated: true, completion: nil)
    }
    
    @IBAction func displayEventEdit(sender: UIButton) {
        let eventVC = EKEventEditViewController()
        
        eventVC.eventStore = eventStore
        eventVC.editViewDelegate = self
        
        presentViewController(eventVC, animated: true, completion: nil)
//        UINavigationBar.appearance().barTintColor = UIColor.blackColor()
    }
    
    // MARK: EKCalendarChooserDelegate
    
    func calendarChooserDidCancel(calendarChooser: EKCalendarChooser) {
        print("Cancel was pressed")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func calendarChooserDidFinish(calendarChooser: EKCalendarChooser) {
        print("Done was pressed")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: EKEventEditViewDelegate
    
    func eventEditViewController(controller: EKEventEditViewController, didCompleteWithAction action: EKEventEditViewAction) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

