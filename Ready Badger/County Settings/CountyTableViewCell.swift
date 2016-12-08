//
//  CountyTableViewCell.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/9/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit
import OneSignal

protocol CountyCellDelegate: class {
    func countySwitchTurned(on: Bool, withCounty county: County)
}

class CountyTableViewCell: UITableViewCell {

    @IBOutlet weak var countyLabel: UILabel!
    var county: County!
    var delegate: CountyCellDelegate?
    @IBOutlet weak var `switch`: UISwitch!
    
    @IBAction func countySwitchTapped(_ sender: UISwitch) {
        CountyWrites.turn(county: county, toSelected: sender.isOn)
        if sender.isOn {
            print(county.name)
            OneSignal.sendTag(county.name, value: "1")
        } else {
            OneSignal.deleteTag(county.name)
        }
    }

}
