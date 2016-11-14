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
    
    let callCallback = { (resource: DisasterResource) in
        let stringArray = resource.phoneNumber.components(
            separatedBy: NSCharacterSet.decimalDigits.inverted)
        let digitsOnly = stringArray.joined(separator: "")
        if let url = URL(string: "tel://\(digitsOnly)") {
            UIApplication.shared.openURL(url)
        }
    }
    
    let mapCallback = { (resource: DisasterResource) in
        let baseUrl : String = "http://maps.apple.com/?q="
        let name = "\(resource.name)"
        let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let finalUrl = baseUrl + encodedName!
        
        let url = URL(string: finalUrl)!
        UIApplication.shared.openURL(url)
    }
    
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
        cell.addressLabel.text = "\(resource!.streetAddress), \(resource!.zipCode)"
        cell.disasterResource = resource
        cell.mapCallback = self.mapCallback
        cell.callCallback = self.callCallback
        
        return cell
    }

}
