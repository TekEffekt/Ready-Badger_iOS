//
//  CountySettingsViewController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/8/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class CountySettingsViewController: UIViewController, DefaultTheme, Searchable, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating {

    @IBOutlet weak var countyTable: UITableView!
    @IBOutlet weak var toolbar: UIToolbar!
    var searchButton: UIBarButtonItem!
    let counties = CountyQueries.getAllCountiesByReigon().0
    var filteredCounties: [String: [County]] = [:]
    let regions = CountyQueries.getAllCountiesByReigon().1
    var filteredRegions = [String]()
    var searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countyTable.dataSource = self
        searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(self.searchPressed(_:)))
        setupSearch()
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        setupToolbar()
    }
    
    private func setupToolbar() {
        let leftSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let rightSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let showSelectedButton = UIBarButtonItem(title: "Show Selected", style: .plain, target: self, action: #selector(self.showSelected))
        toolbar.items = [leftSpace, showSelectedButton, rightSpace]
        showSelectedButton.tintColor = UIColor.tint()
    }
    
    func showSelected() {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "County Cell") as? CountyTableViewCell else {
            return UITableViewCell()
        }
        let counties = getCounties()
        let county = counties[getRegions()[indexPath.section]]?[indexPath.row]
        cell.countyLabel.text = county?.name
        cell.county = county
        cell.switch.isOn = county!.selected
        return cell
    }
    
    func getRegions() -> [String] {
        var regions: [String]
        if searchController.searchBar.isFirstResponder {
            regions = filteredRegions
        } else {
            regions = self.regions
        }
        return regions
    }
    
    func getCounties() -> [String: [County]] {
        var counties: [String: [County]]
        if searchController.searchBar.isFirstResponder {
            counties = filteredCounties
        } else {
            counties = self.counties
        }
        return counties
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let regions = getRegions()
        let region = regions[section]
        return getCounties()[region]?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return getRegions().count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return getRegions()[section]
    }

    @IBAction func searchPressed(_ sender: UIBarButtonItem) {
        startSearch()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cancelSearch()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let filtered = CountySearchLogic.search(withText: searchController.searchBar.text!, andCounties: counties)
        filteredCounties = filtered.0
        filteredRegions = filtered.1
        countyTable.reloadData()
    }
    
}
