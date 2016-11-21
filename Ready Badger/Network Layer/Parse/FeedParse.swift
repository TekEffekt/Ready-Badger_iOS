//
//  FeedParse.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/17/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class FeedParse {
    
    static func parse(data: NSDictionary) -> FeedData {
        var countyData: [CountyData] = []
        let selectedCounties = CountyQueries.getAllSelectedCounties()
        for county in selectedCounties {
            guard let json = data["\(county.id)"] as? NSDictionary else { continue }
            let airQualityJson = json["airquality"] as? NSDictionary
            let weatherJson = json["weather"] as? NSDictionary
            let alertsJson = json["alerts"] as? NSArray
            let roadsJson = json["roads"] as? NSArray
            
            var airQuality: AirQualityData? = nil
            var weather: WeatherData? = nil
            var alerts: [AlertData]? = nil
            var roads: [RoadData]? = nil
            if let jsonDict = airQualityJson {
                airQuality = AirQualityData(title: jsonDict.value(forKey: "title") as! String, description: jsonDict.value(forKey: "description") as! String, countyName: county.name)
            }
            if let jsonDict = weatherJson {
                weather = WeatherData(title: jsonDict.value(forKey: "title") as! String, description: "No Description: Bug", countyName: county.name)
            }
            if let jsonArray = alertsJson {
                alerts = []
                for jsonObject in jsonArray {
                    guard let json = jsonObject as? NSDictionary else { continue }
                    let alert = AlertData(title: json.value(forKey: "title") as! String, description: json.value(forKey: "description") as? String, countyName: county.name)
                    alerts!.append(alert)
                }
            }
            if let jsonArray = roadsJson {
                roads = []
                for jsonObject in jsonArray {
                    guard let json = jsonObject as? NSDictionary else { continue }
                    let roadIncident = RoadData(title: json.value(forKey: "title") as! String, travelDirection: json.value(forKey: "direction_of_travel") as! String, location: json.value(forKey: "location") as! String, roadwayName: json.value(forKey: "roadway_name") as! String, lanesAffected: json.value(forKey: "lanes_affected") as! String, severity: json.value(forKey: "severity") as! String, countyName: county.name)
                    roads!.append(roadIncident)
                }
            }
            
            let countyDataEntry = CountyData(countyName: county.name, weather: weather, airQuality: airQuality, alerts: alerts, roadIncidents: roads)
            countyData.append(countyDataEntry)
        }
        return FeedData(withCountyData: countyData)
    }
    
}
