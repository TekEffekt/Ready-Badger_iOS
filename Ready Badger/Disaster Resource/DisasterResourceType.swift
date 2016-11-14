//
//  DisasterResourceType.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/13/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

enum DisasterResourceType: String {
    case hospital = "Hospital"
    case police = "Police"
    case fire = "Fire"
    case shelters = "Shelters"
    
    static func getAll() -> [DisasterResourceType] {
        return [hospital, police, fire, shelters]
    }
}
