//
//  CountyWrites.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/9/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class CountyWrites {
    
    static func saveCounty(name: String, region: String, weatherAlertCode: String, currentWeatherCode: String,
                           facebook: String, twitter: String, website: String) {
        do {
            let realm = try Realm()
            let county = County()
            county.name = name
            county.region = region
            county.weatherAlertCode = weatherAlertCode
            county.currentWeatherCode = currentWeatherCode
            county.facebook = facebook
            county.twitter = twitter
            county.website = website
            if county.id == 0 {
                county.id = County.incrementID()
            }
            
            try realm.write {
                realm.add(county, update: true)
            }
        } catch _ {
            print("Realm Exception")
        }
    }
    
    static func turn(county: County, toSelected selected: Bool) {
        do {
            let realm = try Realm()
            try realm.write {
                county.selected = selected
            }
        } catch _ {
            print("Realm Exception")
        }
    }
    
}
