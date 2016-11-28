//
//  FeedRequest.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/17/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

struct FeedRequest: BackendRequest {
    
    var endpoint: String {
        return "api/rss"
    }

    var headers: [String : String]? {
        return ["RB-API-KEY" : "testhi"]
    }
    
    var method: BackendServiceMethod {
        return .GET
    }
    
    var parameters: [String : AnyObject]? {
        let selectedCounties = CountyQueries.getAllSelectedCounties()
        var parameters = [String : AnyObject]()
        for county in selectedCounties {
            parameters["\(county.id)"] = "county[]" as AnyObject?
        }
        return parameters
    }
    
    var imageData: Data? {
        return nil
    }
    
    var alernativeUrl: URL? {
        return nil
    }
    
}
