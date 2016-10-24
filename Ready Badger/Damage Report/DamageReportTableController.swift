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
    let damageReportDatasource = DamageReportDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = damageReportDatasource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        view.tintColor = UIColor.tint()
        damageReportDatasource.tableView = tableView
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
                    optionVc.options = DisasterType.getAll().map() {type in return type.rawValue}
                    optionVc.saveOptions = { [weak self] (option: String) in
                        self?.damageReportDatasource.damageReport.disasterType = DisasterType(rawValue: option)
                        self?.tableView.reloadData()
                    }
                case DamageReportSegues.StateSegue.rawValue:
                    optionVc.options = State.list
                    optionVc.saveOptions = { [weak self] (option: String) in
                        self?.damageReportDatasource.damageReport.state = option
                        self?.tableView.reloadData()
                }
                case DamageReportSegues.OwnershipOptions.rawValue:
                    optionVc.options = Answer.getAll().map() {answer in return answer.rawValue}
                    optionVc.saveOptions = { [weak self] (option: String) in
                        self?.damageReportDatasource.damageReport.ownership = Answer(rawValue: option)!
                        self?.tableView.reloadData()
                    }
                case DamageReportSegues.ResidenceHabitable.rawValue:
                    optionVc.options = Answer.getAll().map() {answer in return answer.rawValue}
                    optionVc.saveOptions = { [weak self] (option: String) in
                        self?.damageReportDatasource.damageReport.residenceIsHabitable = Answer(rawValue: option)!
                        self?.tableView.reloadData()
                    }
                default:
                    break
            }
        }
    }

}
