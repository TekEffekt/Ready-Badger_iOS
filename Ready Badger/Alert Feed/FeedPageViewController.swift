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
    var feedData: [String: [FeedItem]] = [:]
    var keyList: [String] = []
    var newData: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTable.dataSource = self
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.reloadTimer), userInfo: nil, repeats: true)
    }
    
    func reloadTimer() {
        if (self.feedTable != nil) && newData {
            self.feedTable.reloadData()
            newData = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        feedTable.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return keyList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedData[keyList[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keyList[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTable.dequeueReusableCell(withIdentifier: "Alert Feed Cell") as! FeedTableViewCell
        let item = feedData[keyList[indexPath.section]]?[indexPath.row]
        cell.countyLabel.text = item?.countyName
        cell.primaryInfoLabel.text = item?.title
        cell.secondaryInfoLabel.text = item?.description
        
        return cell
    }

}
