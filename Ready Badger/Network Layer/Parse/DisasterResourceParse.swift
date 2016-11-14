//
//  LocationParse.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/13/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class DisasterResourceParse {
    
    static func parse(data: NSArray) {
        for dict in data {
            guard let locationDict = dict as? NSDictionary else { continue }
            guard let county = locationDict["county"] as? String else { continue }
            guard let city = locationDict["city"] as? String else { continue }
            guard let name = locationDict["name"] as? String else { continue }
            guard let phoneNumber = locationDict["phoneNumber"] as? String else { continue }
            guard let state = locationDict["state"] as? String else { continue }
            guard let streetAddress = locationDict["streetAddress"] as? String else { continue }
            guard let type = locationDict["type"] as? String else { continue }
            guard let website = locationDict["website"] as? String else { continue }
            guard let zip = locationDict["zipcode"] as? String else { continue }
            guard let facebook = locationDict["facebook"] as? String else { continue }
            guard let twitter = locationDict["twitter"] as? String else { continue }
            
            DisasterResourceWrite.createResource(city: city, county: county, name: name, phoneNumber: phoneNumber, state: state, streetAddress: streetAddress, type: type, website: website, zipCode: zip, facebook: facebook, twitter: twitter)
        }
    }
    
}
