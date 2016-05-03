//
//  ContactViewController.swift
//  ABoynton_CE9
//
//  Created by Allen Boynton on 4/26/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit
import MessageUI
import ContactsUI

// Global Initiators
let cellIdentifier = "Cell"

class ContactViewController: UIViewController, MFMailComposeViewControllerDelegate, CNContactPickerDelegate, CNContactViewControllerDelegate {
    
    // Framework delegates
    var mail = MFMailComposeViewController()
    var contactStore = CNContactStore()
    
    var emailSent: [String] = []
    
    // Outlet for emailed contacts table view
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // VC title
        self.title = "Contacts"
        
        // Get permission to access contacts from contact store
        func requestForAccess(completionHandler: (accessGranted: Bool) -> Void) {
            let authorizationStatus = CNContactStore.authorizationStatusForEntityType(.Contacts)
            
            switch authorizationStatus {
            case .Authorized:
                completionHandler(accessGranted: true)
                
            case .Denied, .NotDetermined:
                self.contactStore.requestAccessForEntityType(.Contacts, completionHandler: { (granted, error) -> Void in
                    if granted {
                        print("Request access FAILED with ERROR \(error)")
                        return
                    }
                    else {
                        if authorizationStatus == .Denied {
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                let message = "\(error!.localizedDescription)\n\nPlease allow the app to access your contacts through the Settings."
                                showMessage(message)
                            })
                        }
                    }
                })
                
            default:
                completionHandler(accessGranted: false)
            }
        }
        
        // Alert that recommends user go to settings
        func showMessage(message: String) {
            let alertController = UIAlertController(title: "Edit Contacts", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            let dismissAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            }
            alertController.addAction(dismissAction)
        }        
    }
    
    // MARK: UITableViewDataSource
    
    // Creates the proper number of cells by the amount of array elements
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // emailSent.count
    }
    
    // Create timestamp for email sent
    var Timestamp: String {
        return "\(NSDate().timeIntervalSince1970)"
    }
    
    // Function deques the table cell as a template for the following cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier (cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = "Email: \("emailAddresses")"
        cell.detailTextLabel?.text = "Timestamp: \(Timestamp)"
        print("Timestamp: \(Timestamp)")
        // Return data
        return cell
    }
    
    // Action button to open contacts VC
    @IBAction func displayContactPicker(sender: UIBarButtonItem) {
        // Configure contact picker
        let picker = CNContactPickerViewController()
        
        // Picker delegate
        picker.delegate = self
        
        // Grays out any contacts without emails
        picker.predicateForEnablingContact = NSPredicate(format: "emailAddresses.@count > 0")
        
        // Present the contact picker view
        presentViewController(picker, animated: true, completion: nil)
    }
    
    // Action button to open new contact screen
    @IBAction func displayNewContact(sender: UIBarButtonItem) {
        // Instantiate a new contact
        let newContact = CNContactViewController(forNewContact: nil)
        
        // New contact delegate
        newContact.delegate = self
        newContact.contactStore = contactStore
        
        // Send nav controller to a contact view
        let nav = UINavigationController(rootViewController: newContact)
        
        // Present the new contact view
        presentViewController(nav, animated: true, completion: nil)
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    // Check against valid sending
    func mailComposerController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        // Checks status of mail sent
        if error == error {
            print("Mail send cancelled...")
        }
        if result == MFMailComposeResultSent {
            print("Mail sent successfully")
            
        } else if result == MFMailComposeResultCancelled {
            print("Mail has been cancelled")
            
        } else if result == MFMailComposeResultSaved {
            print("Your mail has been saved in Drafts")
            
        } else {
            print("Mail not sent with RESULT: \(result)")
        }
        
        // Dismiss regardless of decision
        controller.dismissViewControllerAnimated(true, completion:nil)
    }
    
    // MARK: CNContactPickerDelegate
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
        // Set up properties to send email to those contacts selected
        if contactProperty.key == "emailAddresses" {
            print("Selected the \(contactProperty.value) email")
        }
        return
    }
    
    // MARK: CNContactViewControllerDelegate
    
    func contactViewController(viewController: CNContactViewController, didCompleteWithContact contact: CNContact?) {
        if contact != nil {
            print("We saved the contact")
        } else {
            print("We cancelled")
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
}
