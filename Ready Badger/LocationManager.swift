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

//import Foundation
import UIKit
import CoreLocation
import RealmSwift

class LocationManager : CLLocationManager, CLLocationManagerDelegate {
    
    // MARK: Properties
    static let sharedInstance = LocationManager()
    
    let realm = try! Realm()
    var realmDefaults : RealmUserDefaults?
    
    var currentLocation = Location()
    let locationManager = CLLocationManager()
    var stateWarningWasIssued = false
    var error : String = ""
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.distanceFilter = 1000
        
        if let defaults = realm.object(ofType: RealmUserDefaults.self, forPrimaryKey: Keys.realmUserDefaults.rawValue as AnyObject) {
            realmDefaults = defaults
            stateWarningWasIssued = defaults.outsideWisconsinWarningWasIssued
        }
        
    }
    
    // MARK: Location Requests
    func findLocationFine() {
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
    }
    
    func findLocationCoarse() {
        locationManager.requestAlwaysAuthorization()
        if permissionsAreGranted() {
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        }
    }
    
    func permissionsAreGranted() -> Bool {
        while CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        return true
    }
    
    // MARK: completion
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //        print("location updated at \(NSDate())")
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            if (error != nil) {
                print("Reverse geocoder failed with error: " + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                self.updateLocationInfo(placemark: pm)
            }
        })
    }
    
    // MARK: save new information
    func updateLocationInfo(placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            if locationManager.desiredAccuracy == kCLLocationAccuracyBestForNavigation {
                locationManager.stopUpdatingLocation()
            }
            let state = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            if state != "WI" && !stateWarningWasIssued {
                //                print(state!)
                error = "outside Wisconsin"
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: Keys.locationUpdateError.rawValue), object: self)
                
                stateWarningWasIssued = true
                
                // update Realm defaults
                var settings : RealmUserDefaults?
                if let _ = realmDefaults {
                    settings = realmDefaults
                } else {
                    settings = RealmUserDefaults()
                    settings!.name = Keys.realmUserDefaults.rawValue
                }
                try! realm.write() {
                    settings!.outsideWisconsinWarningWasIssued = true
                    realm.add(settings!, update: true)
                }
            } else {
                let addressNumber = (containsPlacemark.subThoroughfare != nil) ? containsPlacemark.subThoroughfare : ""
                let addressStreet = (containsPlacemark.thoroughfare != nil) ? containsPlacemark.thoroughfare : ""
                let address = addressNumber! + " " + addressStreet!
                let zip = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
                let city = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
                let county = (containsPlacemark.subAdministrativeArea != nil) ? containsPlacemark.subAdministrativeArea : ""
                
                currentLocation.streetAddress = address
                currentLocation.zipCode = zip
                currentLocation.city = city
                currentLocation.county = county
                currentLocation.state = state
                currentLocation.latitude = "\(placemark!.location!.coordinate.latitude)"
                currentLocation.longitude = "\(placemark!.location!.coordinate.longitude)"
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: Keys.locationUpdated.rawValue), object: self)
            }
            
            //            print("current county is ", county!)
        }
        
    }
    
    // MARK: alerts
    func getAlert() -> UIAlertController {
        var alertController = UIAlertController()
        
        switch error {
        case "outside Wisconsin" :
            alertController = UIAlertController(
                title: "current location outside of Wisconsin",
                message: "Data will be shown for your watched counties only.",
                preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            break
        case "gps unavailable" :
            alertController = UIAlertController(
                title: "Location services are unavailable",
                message: "Either manually select your current county, or continue with your always-watched ounties only.",
                preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "Manually select county", style: UIAlertActionStyle.default,handler: nil))
            alertController.addAction(UIAlertAction(title: "Use always-watched only", style: UIAlertActionStyle.default,handler: nil))
            break
        default:
            alertController = UIAlertController(
                title: "Background Location Access Disabled",
                message: "Data will be shown for your watched counties only.  In order to monitor your current county, please open this app's settings and set location access to 'Always'.",
                preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Ignore", style: .cancel, handler: nil))
            
            let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
                if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.openURL(url as URL)
                }
            }
            alertController.addAction(openAction)
            break
            
        }
        
        return alertController
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        self.error = "gpsUnavailable"
    }
    
}
