//
//  ListItemDatasource.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 12/4/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import UIKit

class ListItemDatasource: NSObject, UITableViewDataSource {
    
    private var listItems: [ListItem]
    weak var listTableView: UITableView?
    let list: ReadyList
    
    init(withList list: ReadyList) {
        self.list = list
        listItems = ListItemQueries.getListItems(forList: list)
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listCell = listTableView?.dequeueReusableCell(withIdentifier: "List Item Cell") as? ListItemCell else { return UITableViewCell() }
        let listItem = listItems[indexPath.row]
        listCell.nameLabel.text = listItem.name
        listCell.listItem = listItem
        return listCell
    }
    
    func isEmpty() -> Bool {
        return listItems.isEmpty
    }
    
    func reloadData() {
        listItems = ListItemQueries.getListItems(forList: list)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Your List Items"
    }
    
    func delete(listItem: ListItem, fromList list: ReadyList) {
        ListItemWrites.remove(listItem: listItem, fromList: list)
        reloadData()
    }
    
}
