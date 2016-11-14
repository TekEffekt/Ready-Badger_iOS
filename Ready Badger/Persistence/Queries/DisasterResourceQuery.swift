//
//  DisasterResourceQuery.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/13/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class DisasterResourceQuery {
    
    static func getResources() -> [String: [String: [DisasterResource]]] {
        var result = [String: [String: [DisasterResource]]]()
        let realm = try! Realm()
        let resources = realm.objects(DisasterResource.self)
        let selectedCounties = CountyQueries.getAllSelectedCounties()
        for resource in resources {
            let type = resource.type
            let county = resource.county
            var found = false
            for selected in selectedCounties {
                if selected.name == county {
                    found = true
                }
            }
            if !found {
                continue
            }
            if result[type] == nil {
                result[type] = [:]
            }
            if result[type]?[county] == nil {
                result[type]?[county] = []
            }
            result[type]?[county]!.append(resource)
        }
        return result
    }
    
}
