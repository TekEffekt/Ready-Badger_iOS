//
//  ListDataSource.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 12/4/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import UIKit

class ListDatasource: NSObject, UITableViewDataSource {
    
    private var lists: [ReadyList]
    weak var listTableView: UITableView?
    
    override init() {
        lists = ListItemQueries.getLists()
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listCell = listTableView?.dequeueReusableCell(withIdentifier: "List Cell") as? ListCell else { return UITableViewCell() }
        let list = lists[indexPath.row]
        listCell.nameLabel.text = list.name
        listCell.itemCountLabel.text = "\(list.items.count) items"
        listCell.list = list
        return listCell
    }
    
    func isEmpty() -> Bool {
        return lists.isEmpty
    }
    
    func reloadData() {
        lists = ListItemQueries.getLists()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Your Lists"
    }
    
    func delete(list: ReadyList) {
        ListItemWrites.remove(list: list)
        reloadData()
    }
    
}
