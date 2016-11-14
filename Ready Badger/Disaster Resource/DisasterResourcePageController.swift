//
//  DisasterResourceViewController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/13/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class DisasterResourcePageController: UITableViewController, DefaultTheme {
    
    var resources: [String: [DisasterResource]] = [:] {
        didSet {
            keys = Array(resources.keys)
        }
    }
    var keys: [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return keys.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let num = resources[keys[section]]!.count
        return num
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Resource Cell") as? DisasterResourceCell else { return UITableViewCell() }
        let resource = resources[keys[indexPath.section]]?[indexPath.row]
        cell.nameLabel.text = resource?.name
        
        return cell
    }
    
    

}
