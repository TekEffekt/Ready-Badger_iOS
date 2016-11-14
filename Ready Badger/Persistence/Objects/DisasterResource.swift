//
//  DisasterResource.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/13/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class DisasterResource: Object {
    dynamic var county = ""
    dynamic var name = ""
    dynamic var streetAddress = ""
    dynamic var city = "City"
    dynamic var state = ""
    dynamic var zipCode = ""
    dynamic var phoneNumber = ""
    dynamic var website = ""
    dynamic var type = ""
    dynamic var facebook = ""
    dynamic var twitter = ""
    
    override class func primaryKey() -> String? {
        return "name"
    }
    
}
