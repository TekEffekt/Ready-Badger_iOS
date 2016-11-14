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
        return "locations"
    }
    
    var method: BackendServiceMethod {
        return .GET
    }
    
    var parameters: [String : AnyObject]? {
        return nil
    }
    
    var headers: [String : String]? {
        return ["RB-API-KEY" : "testhi"]
    }
    
    var imageData: NSData? {
        return nil
    }
    
}
