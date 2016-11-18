//
//  FeedData.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/17/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

struct FeedData {
    let countyData: [CountyData]
    
    func getSectionNumber(withOrientation orient: FeedOrientation) -> Int {
        if orient == .byCounty {
            return countyData.count
        } else {
            return 4
        }
    }
    
    func getRowNumber(withOrientation orient: FeedOrientation, forSection section: Int) -> Int {
        if orient == .byCounty {
            let county = countyData[section]
            return numTypes(forCounty: county)
        } else {
            switch section {
            case 1:
                return numCountiesWithWeather()
            case 2:
                return numCountiesWithAlerts()
            case 3:
                return numCountiesWithRoadIncidents()
            case 4:
                return numCountiesWithAirQuality()
            default: return 0
            }
        }
    }
    
    func numTypes(forCounty county: CountyData) -> Int {
        var num = 0
        num += county.weather != nil ? 1 : 0
        num += county.airQuality != nil ? 1 : 0
        if let alerts = county.alerts {
            num += alerts.count
        }
        if let incidents = county.roadIncidents {
            num += incidents.count
        }
        return num
    }
    
    func numCountiesWithAirQuality() -> Int {
        var sum = 0
        for county in countyData {
            sum += county.airQuality != nil ? 1 : 0
        }
        return sum
    }
    
    func numCountiesWithWeather() -> Int {
        var sum = 0
        for county in countyData {
            sum += county.weather != nil ? 1 : 0
        }
        return sum
    }
    
    func numCountiesWithAlerts() -> Int {
        var sum = 0
        for county in countyData {
            if let alerts = county.alerts {
                sum += alerts.count
            }
        }
        return sum
    }
    
    func numCountiesWithRoadIncidents() -> Int {
        var sum = 0
        for county in countyData {
            if let roadIncidents = county.roadIncidents {
                sum += roadIncidents.count
            }
        }
        return sum
    }
    
}
