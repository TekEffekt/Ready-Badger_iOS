//
//  ListDataSource.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 12/4/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class ListDatasource: NSObject, UITableViewDataSource {
    
    private var lists: Results<ReadyList>
    weak var listTableView: UITableView?
    
    override init() {
        lists = ListItemQueries.getLists()
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if lists.isEmpty {
            return 0
        }
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Your Lists"
    }
    
    func delete(list: ReadyList) {
        ListItemWrites.remove(list: list)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let list = (tableView.cellForRow(at: indexPath) as! ListCell).list
        delete(list: list!)
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
    
}
