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
    var dataByCounties: [String: [FeedDataValue]]
    var dataByAlert: [String: [FeedDataValue]]
    var dataByAlertKeys: [String] = ["weather", "alerts", "roads", "airQuality"]
    
    init(withCountyData countyData: [CountyData]) {
        self.countyData = countyData
        dataByCounties = [:]
        dataByAlert = [:]
        for county in countyData {
            var dataValues = [FeedDataValue]()
            if let weather = county.weather {
                if dataByAlert["weather"] == nil {
                    dataByAlert["weather"] = []
                }
                dataByAlert["weather"]?.append(weather)
                dataValues.append(weather)
            }
            if let alerts = county.alerts {
                for alert in alerts {
                    if dataByAlert["alerts"] == nil {
                        dataByAlert["alerts"] = []
                    }
                    dataByAlert["alerts"]?.append(alert)
                    dataValues.append(alert)
                }
            }
            if let roadIncidents = county.roadIncidents {
                for incident in roadIncidents {
                    if dataByAlert["roads"] == nil {
                        dataByAlert["roads"] = []
                    }
                    dataByAlert["roads"]?.append(incident)
                    dataValues.append(incident)
                }
            }
            if let airQuality = county.airQuality {
                if dataByAlert["airQuality"] == nil {
                    dataByAlert["airQuality"] = []
                }
                dataByAlert["airQuality"]?.append(airQuality)
                dataValues.append(airQuality)
            }
            
            dataByCounties[county.countyName] = dataValues
        }
        
        dataByAlertKeys = Array(dataByAlert.keys)
    }
    
    func getCellTitle(forRow row: Int, andSection section: Int, withOrientation orient: FeedOrientation) -> String? {
        if orient == .byType {
            let data = getData(forRow: row, andSection: section, withOrientation: .byType)
            return data?.countyName
        }
        return nil
    }
    
    func getHeader(forSection section: Int, withOrientation orient: FeedOrientation) -> String? {
        if orient == .byCounty {
            return countyData[section].countyName
        } else {
            let key = dataByAlertKeys[section]
            switch key {
            case "weather":
                return "Weather"
            case "alerts":
                return "Alerts"
            case "roads":
                return "Road Incidents"
            case "airQuality":
                return "Air Quality"
            default:
                return nil
            }
        }
    }
    
    func getData(forRow row: Int, andSection section: Int, withOrientation orient: FeedOrientation) -> FeedDataValue? {
        if orient == .byCounty {
            let county = countyData[section]
            let dataForCounty = dataByCounties[county.countyName]
            return dataForCounty![row]
        } else {
            return dataByAlert[dataByAlertKeys[section]]![row]
        }
    }
    
    func getSectionNumber(withOrientation orient: FeedOrientation) -> Int {
        if orient == .byCounty {
            return countyData.count
        } else {
            return dataByAlert.count
        }
    }
    
    func getRowNumber(withOrientation orient: FeedOrientation, forSection section: Int) -> Int {
        if orient == .byCounty {
            let county = countyData[section]
            return numTypes(forCounty: county)
        } else {
            return dataByAlert[dataByAlertKeys[section]]!.count
        }
    }
    
    func getAirQualityData(forRow row: Int) -> AirQualityData {
        var airQualities = [AirQualityData]()
        for county in countyData {
            if let airQuality = county.airQuality {
                airQualities.append(airQuality)
            }
        }
        return airQualities[row]
    }
    
    func getWeatherData(forRow row: Int) -> WeatherData {
        var weatherDatas = [WeatherData]()
        for county in countyData {
            if let weatherData = county.weather {
                weatherDatas.append(weatherData)
            }
        }
        return weatherDatas[row]
    }
    
    func getAlertData(forRow row: Int) -> AlertData {
        var alerts = [AlertData]()
        for county in countyData {
            if let alertArray = county.alerts {
                for alert in alertArray {
                    alerts.append(alert)
                }
            }
        }
        return alerts[row]
    }
    
    func getRoadData(forRow row: Int) -> RoadData {
        var incidents = [RoadData]()
        for county in countyData {
            if let roadArray = county.roadIncidents {
                for incident in roadArray {
                    incidents.append(incident)
                }
            }
        }
        return incidents[row]
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
