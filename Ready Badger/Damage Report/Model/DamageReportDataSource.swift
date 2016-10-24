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
    var damageReport = DamageReport()
    weak var tableView: UITableView?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsFor(section: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = cellsFor(section: indexPath.section)[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellType.rawValue) as? DamageReportCell else {return UITableViewCell() }
        cell.type = cellType
        
        if let labelCell = cell as? DamageReportLabelCell {
            setCellLabel(cell: labelCell)
        } else if let dateCell = cell as? DateCell {
            dateCell.datePicker?.addTarget(self, action: #selector(DamageReportDataSource.datePickerChanged(datePicker:)), for: .valueChanged)
        }
        
        return cell
    }
    
    func datePickerChanged(datePicker: UIDatePicker) {
        damageReport.date = datePicker.date
        tableView?.reloadData()
    }
    
    func setCellLabel(cell: DamageReportLabelCell) {
        switch cell.type {
            case .disasterType:
                cell.label?.text = damageReport.disasterType?.rawValue
            case .date:
                cell.label?.text = damageReport.date != nil ? "\(damageReport.date!)" : ""
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
                return [.basementFlooded]
            case 7:
                return [.description]
            case 8:
                return [.photo]
            default:
                return []
        }
    }
    
}
