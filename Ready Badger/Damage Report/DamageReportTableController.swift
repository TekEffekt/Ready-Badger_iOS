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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        view.tintColor = UIColor.tint()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let optionVc = segue.destination as? OptionController {
            switch segue.identifier! {
                case DamageReportSegues.DisasterTypeSegue.rawValue:
                    optionVc.options = DamageReportOptions.disasterTypes
                default:
                    break
            }
        }
        
    }

}
