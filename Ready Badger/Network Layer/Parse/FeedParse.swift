//
//  FeedParse.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/17/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class FeedParse {
    
    func parse(data: NSDictionary) -> FeedData {
        var countyData: [CountyData] = []
        let selectedCounties = CountyQueries.getAllSelectedCounties()
        for county in selectedCounties {
            guard let json = data["\(county.id)"] as? NSDictionary else { continue }
            let airQuality = json["airquality"]
            let alerts = json["alerts"]
            let weather = json["weather"]
            let roads = json["roads"]
            
            
        }
    }
    
}
