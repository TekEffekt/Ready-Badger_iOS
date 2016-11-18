//
//  CountyData.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/17/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

struct CountyData {
    let countyName: String
    let weather: WeatherData?
    let airQuality: AirQualityData?
    let alerts: [AlertData]?
    let roadIncidents: [RoadData]?
}
