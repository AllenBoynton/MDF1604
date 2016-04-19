//
//  SearchViewController.swift
//  ABoynton_CE5
//
//  Created by Allen Boynton on 4/15/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit

// MARK: Properties

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    // Stored properties
    var searchItems = [SearchItems]()
    var filteredSearch = [SearchItems]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Search"
        
        // MARK: TableViewDataSource
        
        // Custom object array
        searchItems = [
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
        
        // Configure to recieve updates
        searchController.searchResultsUpdater = self
        
        // SearchController setup
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        // SearchBar setup
        searchController.searchBar.scopeButtonTitles = ["All", "Sporting Group", "Working Group"]
        searchController.searchBar.delegate = self
        
        // Adds searchBar to the tableView
        tableView.tableHeaderView = searchController.searchBar
        //
        // Possible bug fix
        searchController.searchBar.sizeToFit()
        
        self.definesPresentationContext = true
        
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredSearch = searchItems.filter { searchItem in
            let categoryMatch = (scope == "All") || (searchItem.group == scope)
            return  categoryMatch && searchItem.name.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }
    
    // MARK: Table View
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active || searchController.searchBar.text != "" {
            return filteredSearch.count
        }
        return searchItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        let searchItem: SearchItems
        if searchController.active && searchController.searchBar.text != "" {
            searchItem = filteredSearch[indexPath.row]
        } else {
            searchItem = searchItems[indexPath.row]
        }
        cell.textLabel!.text = searchItem.name
        
        return cell
    }
    
    // MARK: Segue to details
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == detailSegue {
            if let indexPath = tableView.indexPathForSelectedRow {
                let searchItem: SearchItems
                if searchController.active && searchController.searchBar.text != "" {
                    searchItem = filteredSearch[indexPath.row]
                } else {
                    searchItem = searchItems[indexPath.row]
                }
                let controller = segue.destinationViewController as! DetailViewController
                controller.dogDetail = searchItem
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }

    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
        
    }
    
    // Returns edited text to VC1 textFields
    @IBAction func returnEdit(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
                