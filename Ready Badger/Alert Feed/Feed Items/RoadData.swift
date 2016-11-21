//
//  RoadData.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/17/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

struct RoadData: FeedDataValue {
    let title: String
    let travelDirection: String
    let location: String
    let roadwayName: String
    let lanesAffected: String
    let severity: String
    var countyName: String
}
