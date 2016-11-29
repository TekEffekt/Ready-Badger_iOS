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
    
    var parameters: [Parameter]? {
        let selectedCounties = CountyQueries.getAllSelectedCounties()
        var parameters = [Parameter]()
        for county in selectedCounties {
            parameters.append(Parameter(Key: "county[]", Value: "\(county.id)" as AnyObject))
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
