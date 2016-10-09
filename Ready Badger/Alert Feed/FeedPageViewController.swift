//
//  FeedPageViewController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/3/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class FeedPageViewController: UIViewController, UITableViewDataSource {

    var type: AlertFeedType!
    @IBOutlet weak var feedTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTable.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if type == .type {
            return 2
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let countyTitles = ["Green Bay", "Racine"]
        let typeTitles = ["Current Weather", "Traffic Conditions"]
        
        if type == .county {
            return countyTitles[section]
        } else {
            return typeTitles[section]
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTable.dequeueReusableCell(withIdentifier: "Alert Feed Cell") as! FeedTableViewCell
        let countyTexts = [["Sunny", "Heavy Traffic"], ["Partly Cloudy"]]
        let typeTexts = [["Green Bay", "Racine"], ["Green Bay"]]
        let primaryCountyTexts = [["Sunny and 63 F at Winona, Winoa Municipal Airport-Max Conrad Field, MN", "Heavy traffic at the along 31. Construction near the intersection of 31 and 11."], ["Overcast and 63 F at Racine, Wisconsin - The Fields of Mexico"]]
        let secondaryCountyTexts = [["Winds are Southeast at 3.5 MH (3 KT). The humidity is 88%. Last updated on Sept 23 2016, 11:53 pm CDT.", "Expect 10 minutes more of travel time. Avoid if possible. All lanes are full."], ["Winds are North at 8.5 MH (3 KT). The humidity is 30%. Last updated on Sept 23 2016, 11:53 pm CDT."]]
        let primaryTypeTexts = [["Sunny and 63 F at Winona, Winoa Municipal Airport-Max Conrad Field, MN", "Overcast and 63 F at Racine, Wisconsin - The Fields of Mexico"], ["Heavy traffic at the along 31. Construction near the intersection of 31 and 11."]]
        let secondaryTypeTexts = [["Winds are Southeast at 3.5 MH (3 KT). The humidity is 88%. Last updated on Sept 23 2016, 11:53 pm CDT.", "Winds are North at 8.5 MH (3 KT). The humidity is 30%. Last updated on Sept 23 2016, 11:53 pm CDT."], ["Expect 10 minutes more of travel time. Avoid if possible. All lanes are full."]]
        let countyImages = [["Sunny", "Heavy Traffic"], ["Partly Cloudy"]]
        let typeImages = [["Sunny", "Partly Cloudy"], ["Heavy Traffic"]]
        
        if type == .county {
            cell.countyLabel.text = countyTexts[indexPath.section][indexPath.row]
            cell.weatherIcon.image = UIImage(named: countyImages[indexPath.section][indexPath.row])
            cell.primaryInfoLabel.text = primaryCountyTexts[indexPath.section][indexPath.row]
            cell.secondaryInfoLabel.text = secondaryCountyTexts[indexPath.section][indexPath.row]
        } else {
            cell.countyLabel.text = typeTexts[indexPath.section][indexPath.row]
            cell.weatherIcon.image = UIImage(named: typeImages[indexPath.section][indexPath.row])
            cell.primaryInfoLabel.text = primaryTypeTexts[indexPath.section][indexPath.row]
            cell.secondaryInfoLabel.text = secondaryTypeTexts[indexPath.section][indexPath.row]
        }
        
        return cell
    }

}
