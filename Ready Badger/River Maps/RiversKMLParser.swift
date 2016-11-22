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
import AEXML

class RiversKMLParser {
    
//    // MARK: Properties
    var riverItemList: [RiverItem]?
    var code : String?
    var name : String?
    
    var callbackClosure : ((_ error: NSError?) -> Void)?
    var currentElement : String = ""
    var currentItem : [String : String]?
    var currentCode : String?
    
    init(){
        riverItemList = [RiverItem]()
    }
    
    func parse(data: Data) {
        
        do {
            let xmlDoc = try AEXMLDocument(xml: data)
            if let doc = xmlDoc.root["Document"].first {
        
                if let placemarks = doc["Placemark"].all {
                    for placemark in placemarks {
                        let item = RiverItem()
                        // name or description of the gauge
                        if var name = placemark["name"].value {
                            if let index = name.range(of: "(") {
                                name = name.substring(to: index.lowerBound)
                                item.name = name
                            }
                        }
                        // graph url string
                        if var urlString = placemark["description"].value {
                            if let index1 = urlString.range(of: "gage=") {
                                urlString = urlString.substring(from: index1.upperBound)
                                if let index2 = urlString.range(of: "\">View") {
                                    urlString = urlString.substring(to: index2.lowerBound)
                                    urlString = "http://water.weather.gov/resources/hydrographs/\(urlString)_hg.png"
                                    item.graphURLString = urlString
                                }
                            }
                        }
                        // pin color
                        if var colorString = placemark["styleUrl"].value {
                            if let index = colorString.range(of: "-") {
                                colorString = colorString.substring(from: index.upperBound)
                                item.pinColor = colorString
                            }
                        }
                        // coordinates
                        if let point = placemark["Point"].first {
                            if let coordinateString = point["coordinates"].value {
                                if let commaIndex = coordinateString.range(of: ",") {
                                    let latitudeString = coordinateString.substring(from: commaIndex.upperBound)
                                    let longitudeString = coordinateString.substring(to: commaIndex.lowerBound)
                                    item.latitude = latitudeString
                                    item.longitude = longitudeString
                                    item.location = CLLocation(latitude: CLLocationDegrees(latitudeString)!, longitude: CLLocationDegrees(longitudeString)!)
                                }
                            }
                        }
                        riverItemList?.append(item)
                    }
                }
            }
        }
        catch {
            print("\(error)")
        }
    }
    
}
