//
//  OptionController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/17/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class OptionController: UITableViewController, DefaultTheme {
    
    var options: [String]?
    var saveOptions: ((String) -> Void)!
    var selectedRow: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let cell = tableView.cellForRow(at: IndexPath(row: selectedRow ?? -1, section: 0)) as? OptionTableViewCell else {return}
        saveOptions(cell.optionLabel?.text ?? "")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Option Cell") as? OptionTableViewCell else { return UITableViewCell() }
        cell.optionLabel.text = options?[indexPath.row]
        cell.checkmark.isHidden = !(indexPath.row == selectedRow)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selected = selectedRow {
            toggle(cellAtRow: selected)
        }
        selectedRow = indexPath.row
        toggle(cellAtRow: selectedRow!)
    }
    
    private func toggle(cellAtRow row: Int) {
        guard let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? OptionTableViewCell else {return}
        cell.checkmark.isHidden = !cell.checkmark.isHidden
    }

}
