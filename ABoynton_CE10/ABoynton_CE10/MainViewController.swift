//
//  MainViewController.swift
//  ABoynton_CE10
//
//  Created by Allen Boynton on 4/26/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit
import WebKit


// Global Identifiers
let cellID = "Cell"
let segueID = "toDetail"


class MainViewController: UIViewController {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var partyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the session
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        // Create the session
        let session = NSURLSession(configuration: config)
        
        if let jsonURL = NSURL(string: "https://swapi.co/api/starships/?format=json") {
            
            let task = session.dataTaskWithURL(jsonURL, completionHandler: { (data, response, error) -> Void in
                
                // Check for error and optional binding
                if let error = error {
                    print("Data Task fail with ERROR \(error)")
                    return
                }
                print("Successful")
                
                // Check response status from URL to make sure it is valid
                if let http = response as? NSHTTPURLResponse, data = data {
                    if http.statusCode == 200 {
                        
                        var names = [String]()
                        
                        do {
                            
                            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                            
                            if let results = json["results"] as? [[String: AnyObject]] {
                                for result in results {
                                    if let name = result["name"] as? String {
                                        names.append(name)
                                        for result in results {
                                            if let starship_class = result["starship_class"] as? String {
                                                names.append(starship_class)
                                            }
                                        }
                                    }
                                }
                            }
                        } catch {
                            print("error serializing JSON: \(error)")
                        }
                        dispatch_async(dispatch_get_main_queue()) {
                            self.jsonText.text = String(names)
                        }
                        print(names)
                    }
                }
            })
            task.resume()
        }
    }
}

