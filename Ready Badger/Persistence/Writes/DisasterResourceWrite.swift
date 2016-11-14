//
//  LocationWrite.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/13/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class DisasterResourceWrite {
    
    static func createResource(city: String, county: String, name: String, phoneNumber: String, state: String, streetAddress: String, type: String, website: String, zipCode: String, facebook: String, twitter: String) {
        let resource = DisasterResource()
        resource.city = city
        resource.county = county
        resource.name = name
        resource.phoneNumber = phoneNumber
        resource.state = state
        resource.streetAddress = streetAddress
        resource.type = type
        resource.website = website
        resource.zipCode = zipCode
        resource.facebook = facebook
        resource.twitter = twitter
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(resource, update: true)
        }
    }
    
}
