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
import UIKit
import MapKit

class CustomAnnotation : NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    var custom_image: Bool = true
    var pinImage : UIImage?
    var title : String?
    var subtitle : String?
    var graphURLString : String?
    
    override init() {
        super.init()
    }
}

