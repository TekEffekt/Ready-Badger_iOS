//
//  DataInit.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/28/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class DataInitialization {
    
    static func initialize() {
        if UserDefaults.standard.bool(forKey: "Counties Downloaded") == false {
            NetworkQueue.shared.addOperation(AllCountyOperation(withRequest: AllCountyRequest()))
        }
        
        if UserDefaults.standard.bool(forKey: "Resources Downloaded") == false {
            NetworkQueue.shared.addOperation(DisasterResourceOperation(withRequest: DisasterResourceRequest()))
        }
    }
    
}
