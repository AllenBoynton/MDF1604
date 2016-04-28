//
//  ViewController.swift
//  ABoynton_CE9
//
//  Created by Allen Boynton on 4/28/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit
import MessageUI
import ContactsUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    // Framework delegates
    let mail = MFMailComposeViewController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // VC title
        self.title = "Compose Mail"
    }
    
    @IBAction func composeMail(sender: UIBarButtonItem) {
        // Check to send mail
        if MFMailComposeViewController.canSendMail() {
            // Configure populations
            mail.setToRecipients(["aboynton@fullsail.edu"])
            mail.setCcRecipients([""])
            mail.setBccRecipients([""])
            mail.setSubject("Coding Exercise 9")
            
            // Configure message body
            mail.setMessageBody("", isHTML: true)
            mail.setMessageBody("This is the result of my Coding Exercise 09: MessageUI and Contacts Framework.", isHTML:false) // HTML text
            
            // Mail composing delegate
            mail.mailComposeDelegate = self
            
            // Presenting the Mail Compose View
            presentViewController(mail, animated:true, completion:nil)
            
        }
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    // Check against valid sending
    func mailComposerController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!){
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
}

