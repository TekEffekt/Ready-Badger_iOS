//
//  DisasterInfoType.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/12/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

enum DisasterInfoType: String {
    case tornado = "Tornado"
    case thunderstorm = "Thunderstorm"
    case winterStorm = "Winter Storm"
    case extremeHeat = "Extreme Heat"
    case flood = "Flood"
    case fire = "Fire"
    case powerOutage = "Power Outage"
    case publicHealthEmergency = "Public Health Emergency"
    case hazardousMaterial = "Hazardous Material"
    case bombThreat = "Bomb Threat"
    
    static func getAll() -> [DisasterInfoType] {
        return [tornado, thunderstorm, winterStorm, extremeHeat, flood, fire, powerOutage,
        publicHealthEmergency, hazardousMaterial, bombThreat]
    }
}
