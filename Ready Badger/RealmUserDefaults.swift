/*
 * Copyright 2016 UW-Parkside AppFactory
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

import RealmSwift

class RealmUserDefaults: Object {
    
    dynamic var name = ""
    // RSS Grouping
    dynamic var groupRSSByCountyEnabled = true
    
    // RSS Feeds
    dynamic var currentWeatherEnabled = true
    dynamic var trafficIncidentsEnabled = true
    dynamic var roadConditionsEnabled = true
    dynamic var generalAlertsEnabled = true
    dynamic var airQualityAlertsEnabled = true
    dynamic var weatherAlertsEnabled = true
    
    // Out-of-state warning was issued
    dynamic var outsideWisconsinWarningWasIssued = false
        
    // Warning for not having any watched counties
    dynamic var noWatchedCountiesWarningWasIssued = false
    
    override class func primaryKey() -> String {
        return "name"
    }
    
    override static func indexedProperties() -> [String] {
        return ["name"]
    }
    
}
