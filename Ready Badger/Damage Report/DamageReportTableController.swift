//
//  DamageReportTableController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/17/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class DamageReportTableController: FormTableViewController, DefaultTheme, MenuItem {

    var menu: HamburgerMenu?
    @IBOutlet weak var disasterTypeLabel: UILabel!
    var damageReportDatasource = DamageReportDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = damageReportDatasource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        view.tintColor = UIColor.tint()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if damageReportDatasource.dateSelectMode && indexPath.section == 0 && indexPath.row == 2 {
            return 216
        } else {
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            damageReportDatasource.dateSelectMode = !damageReportDatasource.dateSelectMode
            tableView.beginUpdates()
            if damageReportDatasource.dateSelectMode {
                tableView.insertRows(at: [IndexPath(row: 2, section: 0)], with: .fade)
            } else {
                tableView.deleteRows(at:  [IndexPath(row: 2, section: 0)], with: .fade)
            }
            tableView.endUpdates()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let optionVc = segue.destination as? OptionController {
            switch segue.identifier! {
                case DamageReportSegues.DisasterTypeSegue.rawValue:
                    optionVc.options = DamageReportOptions.disasterTypes
                    optionVc.saveOptions = { [weak self] (options: [String]) in
                        self?.disasterTypeLabel.text = options.first
                    }
                default:
                    break
            }
        }
    }

}
