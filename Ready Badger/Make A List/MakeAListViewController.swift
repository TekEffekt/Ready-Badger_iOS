//
//  MakeAListViewController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 12/3/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class MakeAListViewController: UITableViewController, MenuItem, DefaultTheme {

    var menu: HamburgerMenu?
    let dataSource = ListDatasource()
    var chosenList: ReadyList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        dataSource.listTableView = tableView
        dataSource.reloadData()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let listCell = tableView.cellForRow(at: indexPath) as? ListCell else { return }
        chosenList = listCell.list
        performSegue(withIdentifier: "Show List Detail", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
        
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
        let list = (tableView.cellForRow(at: indexPath) as! ListCell).list
        dataSource.delete(list: list!)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let listDetailVc = segue.destination as? ListDetailController {
            listDetailVc.list = chosenList!
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
