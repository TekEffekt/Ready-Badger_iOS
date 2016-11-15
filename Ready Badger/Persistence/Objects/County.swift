//
//  County.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/9/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class County: Object {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var region = ""
    dynamic var weatherAlertCode = ""
    dynamic var currentWeatherCode = ""
    dynamic var facebook = ""
    dynamic var twitter = ""
    dynamic var website = ""
    dynamic var timestamp: NSDate?
    dynamic var selected = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
