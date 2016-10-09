//
//  Searchable.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/9/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import UIKit

protocol Searchable: class {
    var searchController: UISearchController { set get }
    var searchButton: UIBarButtonItem! { set get }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
}

extension Searchable where Self: UIViewController {
    
    func startSearch() {
        navigationItem.rightBarButtonItem = nil
        navigationItem.hidesBackButton = true
        navigationItem.titleView = searchController.searchBar
        searchController.searchBar.becomeFirstResponder()
    }
    
    func cancelSearch() {
        navigationItem.titleView = nil
        searchController.searchBar.resignFirstResponder()
        navigationItem.rightBarButtonItem = searchButton
        navigationItem.hidesBackButton = false
    }
    
    func setupSearch() {
        navigationItem.rightBarButtonItem = searchButton
        searchController = UISearchController(searchResultsController: nil)
        let searchBar = searchController.searchBar
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchBar.searchBarStyle = .prominent
        searchBar.tintColor = UIColor.tint()
    }
    
}
