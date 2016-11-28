//
//  CurrentWeatherRequest.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/9/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

struct CurrentWeatherRequest: BackendRequest {
    
    let currentWeatherCode: String
    
    var endpoint: String {
        return "RSS/currentWeather/RB-API-KEY/testhi/currentWeatherCode/\(currentWeatherCode)"
    }
    
    var method: BackendServiceMethod {
        return .GET
    }
    
    var parameters: [String : AnyObject]? {
        return nil
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var imageData: Data? {
        return nil
    }
    
    var alernativeUrl: URL? {
        return nil
    }
    
}
