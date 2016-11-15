//
//  AllCountyRequest.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/9/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

struct AllCountyRequest: BackendRequest {
    
    var endpoint: String {
        return "api/counties"
    }
    
    var method: BackendServiceMethod {
        return .GET
    }
    
    var headers: [String : String]? {
        return ["RB-API-KEY" : "testhi"]
    }
    
    var imageData: NSData? {
        return nil
    }
    
    var parameters: [String : AnyObject]? {
        return nil
    }
    
}
