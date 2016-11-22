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

import Foundation
import CoreLocation

class RiverItem: NSObject {
    
    // MARK: Properties
    var pinColor : String?
    var latitude : String?
    var longitude : String?
    var location : CLLocation?
    var graphURLString : String?
    var name : String?
    var observationText : String?
    var observationMeasurement : String?
    
    init(name : String, graphURLString : String, latitude : String, longitude : String, hexColorString : String) {
        super.init()
        self.name = name
        self.graphURLString = graphURLString
        self.latitude = latitude
        self.longitude = longitude
        self.location = CLLocation(latitude: CLLocationDegrees(latitude)!, longitude: CLLocationDegrees(longitude)!)
        
        self.pinColor = hexColorString
        
    }
    
    override init() {
        super.init()
    }
    
    required init(coder decoder : NSCoder){
        super.init()
    }
    
}