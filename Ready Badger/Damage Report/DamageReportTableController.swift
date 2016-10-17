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
                    optionVc.saveOptions = { [weak self] (options: [String]) in
                        self?.disasterTypeLabel.text = options.first
                    }
                default:
                    break
            }
        }
        
    }

}
