//
//  MakeAListViewController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 12/3/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class MakeAListViewController: UITableViewController, MenuItem, DefaultTheme, EmptyState {

    var menu: HamburgerMenu?
    let dataSource = ListDatasource()
    var chosenList: ReadyList?
    var emptyState: EmptyStateView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        dataSource.vcWithEmptyState = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        dataSource.listTableView = tableView
        tableView.reloadData()
        checkIfEmpty()
    }
    
    func checkIfEmpty() {
        if dataSource.isEmpty() {
            configureEmptyState(ofType: .makeAList, hidden: false)
        } else {
            configureEmptyState(ofType: .makeAList, hidden: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let listCell = tableView.cellForRow(at: indexPath) as? ListCell else { return }
        chosenList = listCell.list
        performSegue(withIdentifier: "Show List Detail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let listDetailVc = segue.destination as? ListDetailController {
            listDetailVc.list = chosenList!
        }
    }

}
