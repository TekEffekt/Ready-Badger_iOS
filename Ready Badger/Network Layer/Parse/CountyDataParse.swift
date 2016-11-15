//
//  CountyDataParse.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/9/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class CountyDataParse: BackendResponseParse {
    
    static func parse(data: NSObject) {
        guard let array = data as? NSArray else { return }
        for county in array {
            guard let dict = county as? NSDictionary else {return}
            let name = (dict["county"] as? String) ?? ""
            let reigon = (dict["region"] as? String) ?? ""
            let weatherAlertCode = (dict["weatherAlertCode"] as? String) ?? ""
            let currentWeatherCode = (dict["currentWeatherCode"] as? String) ?? ""
            let facebook = (dict["facebook"] as? String) ?? ""
            let twitter = (dict["twitter"] as? String) ?? ""
            let website = (dict["website"] as? String) ?? ""
            let id = Int((dict["id"] as? String) ?? "") ?? 0
            
            CountyWrites.saveCounty(name: name, region: reigon, weatherAlertCode: weatherAlertCode, currentWeatherCode: currentWeatherCode, facebook: facebook, twitter: twitter, website: website, id: id)
        }
    }
    
}
