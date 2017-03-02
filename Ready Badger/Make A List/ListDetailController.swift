//
//  ListDetailController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 12/4/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class ListDetailController: UITableViewController, MenuItem, DefaultTheme, EmptyState {

    var menu: HamburgerMenu?
    var dataSource: ListItemDatasource!
    var list: ReadyList!
    var chosenItem: ListItem?
    var emptyState: EmptyStateView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        dataSource = ListItemDatasource(withList: list)
        tableView.dataSource = dataSource
        dataSource.listTableView = tableView
        dataSource.vcWithEmptyState = self
        tableView.reloadData()
        title = list.name
        checkIfEmpty()
    }
    
    func checkIfEmpty() {
        if dataSource.isEmpty() {
            configureEmptyState(ofType: .listItem, hidden: false)
        } else {
            configureEmptyState(ofType: .listItem, hidden: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let listCell = tableView.cellForRow(at: indexPath) as? ListItemCell else { return }
        chosenItem = listCell.listItem
        performSegue(withIdentifier: "Edit List Item", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editItemVc = (segue.destination as? UINavigationController)?.topViewController as? EditListItemController {
            editItemVc.list = list
        } else if let editItemVc = segue.destination as? EditListItemController {
            editItemVc.list = list
            if let item = chosenItem {
                editItemVc.listItem = item
            }
        }
    }

}
