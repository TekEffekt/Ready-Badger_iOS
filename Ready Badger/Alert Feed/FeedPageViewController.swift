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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTable.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTable.dequeueReusableCell(withIdentifier: "Alert Feed Cell") as! FeedTableViewCell

        
        
        return cell
    }

}
