//
//  CountyQueries.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/9/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class CountyQueries {
    
    static func getAllCounties() -> [County] {
        do {
            let realm = try Realm()
            let counties = realm.objects(County.self)
            return Array(counties)
        } catch {
            print("Realm Exception")
        }
        
        return []
    }
    
    static func getAllCountiesByReigon() -> ([String: [County]], [String]) {
        let counties = getAllCounties()
        var organized: [String: [County]] = [:]
        var regions = [String]()
        
        for county in counties {
            if organized[county.region] == nil {
                organized[county.region] = []
                regions.append(county.region)
            }
            organized[county.region]?.append(county)
        }
        
        return (organized, regions)
    }
    
}
