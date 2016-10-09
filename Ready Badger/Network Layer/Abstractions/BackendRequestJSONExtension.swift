//
//  BackendRequestJSONExtension.swift
//  Safety Survey
//
//  Created by Kyle Zawacki on 8/22/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

extension BackendRequest {
    
    func getJsonHeader() -> [String: String] {
        return ["Content-Type" : "application/json"]
    }
    
}
