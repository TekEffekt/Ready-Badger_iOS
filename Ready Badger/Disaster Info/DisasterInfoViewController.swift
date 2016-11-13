//
//  DisasterInfoViewController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/7/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class DisasterInfoViewController: UITableViewController, MenuItem, DefaultTheme {

    var menu: HamburgerMenu?
    var chosenType: DisasterInfoType = .flood
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenType = DisasterInfoType.getAll()[indexPath.row]
        performSegue(withIdentifier: "Show Disaster Info", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let page = segue.destination as? DisasterInfoPageController {
            page.disasterType = chosenType
            page.title = chosenType.rawValue
        }
    }
    
}
