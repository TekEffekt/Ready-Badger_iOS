//
//  DisasterType.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/23/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

enum DisasterType: String {
    case flood = "Flood"
    case severeStorm = "Severe Storm"
    case fire = "Fire"
    case sewerBackup = "Sewer Backup"
    case other = "Other"

    static func getAll() -> [DisasterType] {
        return [.flood, .severeStorm, .fire, .sewerBackup, .other]
    }
    
}
