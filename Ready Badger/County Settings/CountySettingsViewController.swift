//
//  CountySettingsViewController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/8/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class CountySettingsViewController: UIViewController, DefaultTheme, UITableViewDataSource {

    @IBOutlet weak var countyTable: UITableView!
    @IBOutlet weak var toolbar: UIToolbar!
    let counties = CountyQueries.getAllCountiesByReigon().0
    let regions = CountyQueries.getAllCountiesByReigon().1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countyTable.dataSource = self
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
        cell.countyLabel.text = counties[regions[indexPath.section]]?[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let region = regions[section]
        return counties[region]?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return regions.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return regions[section]
    }

}
