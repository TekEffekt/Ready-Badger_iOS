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
import SwiftyJSON

class RiverMapViewController: UIViewController, MenuItem, MKMapViewDelegate {
    
    // MARK: Properties
    var menu: HamburgerMenu?
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 100000
    var riverGauges = Set<RiverItem>()
    var updating = false
    let parser = RiversKMLParser()
    var annotations : [CustomAnnotation]?
    
    var kmlURLString = "http://water.weather.gov/ahps2/ahps_kml.php?state=wi&fcst_type=obs"
    
    @IBOutlet weak var bannerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        // register the observer for when all river level data has been processed
        NotificationCenter.default.addObserver(self, selector: #selector(RiverMapViewController.riverLevelsWereUpdated), name: NSNotification.Name(rawValue: Keys.riverLevelsUpdated.rawValue), object: nil)
        
        // use the LocationManager to get the current location, just for centering the map
        let lh = LocationManager.sharedInstance
        
        // if the app doesn't have location permissions, just center it somewhere around Baraboo
        if let initialLocation = lh.locationManager.location {
            centerMapOnLocation(location: initialLocation)
        } else {
            centerMapOnLocation(location: CLLocation(latitude: 44.7862968, longitude: -89.8267049))
        }
        
        getDataFromKML()
    }
    
    // process the KML file from NOAA
    func getDataFromKML() {
        
        updating = true
        
        if let kmlURL = NSURL(string: kmlURLString) {
            let urlRequest = NSURLRequest(url: kmlURL as URL)
            let session = URLSession.shared
            
            let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: {(data, response, error) in
                if data != nil {
                    self.parser.parse(data: data!)
                }
                // hop back on the main thread and start updating things once the data's been processed
                OperationQueue.main.addOperation {
                    self.riverLevelsWereUpdated()
                }
            })
            task.resume()
        }
    }
    
    func riverLevelsWereUpdated() {
        
        riverGauges = Set<RiverItem>()
        
        // add all items created from the KML into the set of RiverItems
        if let items = parser.riverItemList {
            for i in items {
                riverGauges.insert(i)
            }
        }
        
        // ...annotate the map
        annotateMap()
    }
    
    func annotateMap() {
        let priority = DispatchQueue.GlobalQueuePriority.default
        // create annotations for each gauge in a background thread
        for r in riverGauges {
            let queue = OperationQueue()
            queue.addOperation {
                let annotation = CustomAnnotation()
                annotation.coordinate = r.location!.coordinate
                annotation.title = r.name!
                annotation.graphURLString = r.graphURLString
                
                // set the "pin" color to match its level in the graph
                if let color = r.pinColor?.lowercased() {
                    switch color {
                    case "cc33ff" :
                        annotation.pinImage = UIImage(named:"purple")
                        break
                    case "ff0000" :
                        annotation.pinImage = UIImage(named:"red")
                        break
                    case "ff9900" :
                        annotation.pinImage = UIImage(named:"orange")
                        break
                    case "ffff00" :
                        annotation.pinImage = UIImage(named:"yellow")
                        break
                    case "00ff00" :
                        annotation.pinImage = UIImage(named:"white")
                        break
                    default:
                        annotation.pinImage = UIImage(named:"grey")
                    }
                    
                    OperationQueue.main.addOperation {
                        self.mapView.addAnnotation(annotation)
                    }
            }
        }
        }
    }

    // create the callout annotations with the custom classes
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let calloutAnnotationViewIdentifier = "CalloutAnnotation"
        let customAnnotationViewIdentifier = "CustomAnnotation"
        
        if annotation is CustomAnnotation {
            var av = mapView.dequeueReusableAnnotationView(withIdentifier: customAnnotationViewIdentifier)
            
            let customAnnotation = annotation as! CustomAnnotation
            let pinImage = customAnnotation.pinImage
            
            if av != nil {
                av!.annotation = annotation
            } else {
                av = MKAnnotationView(annotation: annotation, reuseIdentifier: customAnnotationViewIdentifier)
            }
            av!.image = pinImage!
            av!.canShowCallout = false
            return av
        } else if annotation is CalloutAnnotation {
            var pin = mapView.dequeueReusableAnnotationView(withIdentifier: calloutAnnotationViewIdentifier)
            if pin == nil {
                pin = CalloutAnnotationView(annotation: annotation, reuseIdentifier: calloutAnnotationViewIdentifier)
                pin?.canShowCallout = false
            } else {
                pin?.annotation = annotation
            }
            return pin
        }
        
        return nil
    }
    
    // assign graph strings to the annotation once they're selected, then open the callout
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? CustomAnnotation {
            let calloutAnnotation = CalloutAnnotation(annotation: annotation)
            
            if let urlString = annotation.graphURLString {
                calloutAnnotation.graphURLString = urlString
            }
            
            mapView.addAnnotation(calloutAnnotation)
            OperationQueue.main.addOperation {
                mapView.selectAnnotation(calloutAnnotation, animated: false)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if let annotation = view.annotation as? CalloutAnnotation {
            mapView.removeAnnotation(annotation)
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.mapType = MKMapType.hybrid
    }
    
}


