//
//  BoundaryString.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/28/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class BoundaryString {
    
    static func get() -> String{
        return "Boundary-\(NSUUID().uuidString)"
    }
    
}
