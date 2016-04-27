//
//  ViewController.swift
//  ABoynton_CE8
//
//  Created by Allen Boynton on 4/24/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var myWebView: UIWebView!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load request to web
        // Complete with optional binding
        if let url = NSURL(string: "https://www.google.com/?gws_rd=ssl") {
            myWebView.loadRequest(NSURLRequest(URL: url))
        }
    }
    
    // MARK: WKNavigationDelegate
    
    // Set to connect to the web
    func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!) {
        print("Started")
    }
    
    // Checks if any errors occured and it failed
    func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
        print("Failed with error \(error)")
    }
    
    // Reaching web was successful
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        print("Finished")
    }
    
    // Allows the back or forward button to not be available if there is nowhere to go
    override func viewWillAppear(animated: Bool) {
        if backButton.enabled {
            myWebView.canGoBack
        }
        if forwardButton.enabled {
        myWebView.canGoForward
        }
    }
    
    // Create back button for web view
    @IBAction func goBack(sender: UIBarButtonItem) {
        if myWebView.canGoBack {
            myWebView.goBack()
        }
    }

    // Create forward button for web view
    @IBAction func goForward(sender: UIBarButtonItem) {
        if myWebView.canGoForward {
            myWebView.goForward()
        }
    }

    // Refresh web view
    @IBAction func refreshButton(sender: UIBarButtonItem) {
        myWebView.reload()
    }
    
    // Go button to enter url entered into address window
    @IBAction func tappedGo(sender: UIBarButtonItem) {
        
        // Checks that address is not empty
        if addressTextField.text == "" {
            return
        }
        guard let text: String = addressTextField.text else {
            return
        }
        
        if text.rangeOfString(".") != nil {
            
            // Creates all entries to lowercase
            var finalString: String = text.lowercaseString
            
            // Adds web address initializer if not entered
            if finalString.rangeOfString("https://") == nil {
                finalString = "https://\(finalString)"
            }
            self.loadURL(finalString)
        }
    }
    
    // Loads the web address
    func loadURL(str: String) {
        let url = NSURL(string: str)
        let request = NSURLRequest(URL: url!)
        
        myWebView.loadRequest(request)
    }
    
    // Create action for cancel button on web view
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        if myWebView.loading {
            myWebView.stopLoading()
        }
    }
    
    // Verifies that web page finished loading
    func webViewDidFinishLoad(webView: UIWebView) {
        if backButton.enabled {
            myWebView.canGoBack
        }
        if forwardButton.enabled {
            myWebView.canGoForward
        }
    }
}

