//
//  TableViewController.swift
//  ABoynton_CE5
//
//  Created by Allen Boynton on 4/18/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {

    // Stored properties
    var filteredSearch: [SearchItems] = []
    
    var searchController = UISearchController(searchResultsController: nil)
    
    // Outlet for the display of tableView
//    @IBOutlet weak var tableView: UITableView!
    
    // MARK: TableViewDataSource
    
    // Custom object array
    let searchItems = [
        SearchItems(name: "Brittany", group: "Sporting Group"),
        SearchItems(name: "Chesapeake Bay Retriever", group: "Sporting Group"),
        SearchItems(name: "Cocker Spaniel", group: "Sporting Group"),
        SearchItems(name: "Golden Retriever", group: "Sporting Group"),
        SearchItems(name: "Irish Setter", group: "Sporting Group"),
        SearchItems(name: "Labrador Retriever", group: "Sporting Group"),
        SearchItems(name: "Alaskan Malamute", group: "Working Group"),
        SearchItems(name: "Boerboel", group: "Working Group"),
        SearchItems(name: "Boxer", group: "Working Group"),
        SearchItems(name: "Cane Corso", group: "Working Group"),
        SearchItems(name: "Doberman Pinscher", group: "Working Group"),
        SearchItems(name: "Rottweiler", group: "Working Group")
    ]
    
    // Function to determine how many cell rows are present
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // if statement counts the array displayed whether it is filtered or not
        if searchController.active {
            filteredSearch.count
        }
        return searchItems.count
    }
    
    // Function to determine how many cells to be passed in
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath:indexPath)
        
        // if statement counts the array displayed whether it is filtered or not
        if searchController.active {
            cell.textLabel?.text = filteredSearch[indexPath.row].name
        } else {
            cell.textLabel?.text = searchItems[indexPath.row].name
        }
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: SearchController
        
        navigationItem.title = "Search"
        
        // SearchController setup
        searchController.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        
        // Configure to recieve updates
        searchController.searchResultsUpdater = self
        
        // SearchBar setup
        searchController.searchBar.scopeButtonTitles = ["All", "Sporting Group", "Working Group"]
        searchController.searchBar.delegate = self
        
        // Adds searchBar to the tableView
        tableView.tableHeaderView = searchController.searchBar
        
        // Possible bug fix
        searchController.searchBar.sizeToFit()
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        // Determines what the user typed and what scope is
        let searchText = searchController.searchBar.text!
        let scopeButtonTitles = searchController.searchBar.scopeButtonTitles! // Gets all titles
        let selectedIndex = searchController.searchBar.selectedScopeButtonIndex // Gets selected scope index
        let scopeTitle = scopeButtonTitles[selectedIndex] // Gets scope titles
        
        filteredSearch = searchItems // Allows the table to be populated upon initiation
        
        // Only if there is text, the titles will begin to be filtered
        if searchText.isEmpty == false {
            filteredSearch = searchItems.filter { (searchItem) -> Bool in
                searchItem.name!.lowercaseString.containsString(searchText.lowercaseString)
            }
        }
        
        // if statement allows search to include all titles
        if scopeTitle != "All" {
            
        } else if scopeTitle == "Sporting Group" {
            
        } else {
            
        }
        
        // Reload data after filtered
        tableView.reloadData()
    }
    
    //    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    //        <#code#>
    //    }
    
    // MARK: UISearchBarDelegate
    

}
