//
//  DisasterResourceRequest.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/13/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

struct DisasterResourceRequest: BackendRequest {
    
    var endpoint: String {
        return "api/v0.5/index.php/locations"
    }
    
    var method: BackendServiceMethod {
        return .GET
    }
    
    var parameters: [Parameter]? {
        return [(Key: "RB-API-KEY", Value: "testhi" as AnyObject)]
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var imageData: Data? {
        return nil
    }
    
    var alernativeUrl: URL? {
        return URL(string: "http://readybadger.org")
    }
    
}
