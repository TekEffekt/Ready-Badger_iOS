//
//  DamageReportDataSource.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/24/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import UIKit

class DamageReportDataSource: NSObject, UITableViewDataSource {
    
    let numberOfSections = 8
    var dateSelectMode = false
    var floodedMode = false
    var damageReport = DamageReport()
    weak var tableView: UITableView?
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsFor(section: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = cellsFor(section: indexPath.section)[indexPath.row]
        print(cellType)
        print(cellType.rawValue)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellType.rawValue) as? DamageReportCell else {return UITableViewCell() }
        cell.type = cellType
        
        if let labelCell = cell as? DamageReportLabelCell {
            setCellLabel(cell: labelCell)
        } else if let dateCell = cell as? DateCell {
            dateCell.datePicker?.addTarget(self, action: #selector(DamageReportDataSource.datePickerChanged(datePicker:)), for: .valueChanged)
        } else if let basementFlooded = cell as? BasementFloodedCell {
            basementFlooded.floodedSwitch.addTarget(self, action: #selector(self.floodSwitchTapped(floodSwitch:)), for: .valueChanged)
        }
        
        return cell
    }
    
    func datePickerChanged(datePicker: UIDatePicker) {
        damageReport.date = datePicker.date
        tableView?.reloadData()
    }
    
    func floodSwitchTapped(floodSwitch: UISwitch) {
        floodedMode = floodSwitch.isOn
        let paths = [IndexPath(row: 1, section: 6), IndexPath(row: 2, section: 6)]
        tableView?.beginUpdates()
        if floodedMode {
            tableView?.insertRows(at: paths, with: .fade)
        } else {
            tableView?.deleteRows(at: paths, with: .fade)
        }
        tableView?.endUpdates()
    }
    
    func setCellLabel(cell: DamageReportLabelCell) {
        switch cell.type {
            case .disasterType:
                cell.label?.text = damageReport.disasterType?.rawValue
            case .date:
                cell.label?.text = damageReport.date != nil ? dateFormatter.string(from: damageReport.date!) : ""
            case .state:
                cell.label?.text = damageReport.state
            case .ownership :
                cell.label?.text = damageReport.ownership.rawValue
            case .residenceHabitable:
                cell.label?.text = damageReport.residenceIsHabitable.rawValue
            case .description:
                cell.label?.text = damageReport.description
            default: break
        }
    }
    
    func cellsFor(section: Int) -> [DamageReportCellType] {
        switch section {
            case 0:
                return dateSelectMode ? [.disasterType, .date, .datePicker] : [.disasterType, .date]
            case 1:
                return [.name, .phoneNumber]
            case 2:
                return [.address, .city, .state, .zipCode]
            case 3:
                return [.ownership]
            case 4:
                return [.insuranceDeductible, .percentLoss, .damageEstimate]
            case 5:
                return [.residenceHabitable]
            case 6:
                return floodedMode ? [.basementFlooded, .waterInches, .livingInBasement] : [.basementFlooded]
            case 7:
                return [.description, .photo]
            default:
                return []
        }
    }
    
}
