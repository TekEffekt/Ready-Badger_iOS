//
//  CountySearchLogic.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/9/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class CountySearchLogic {
    
    static func search(withText text: String, andCounties counties: [String: [County]]) -> ([String: [County]], [String]) {
        var filteredCounties = [String: [County]]()
        
        for pair in counties {
            if pair.key.lowercased().contains(text.lowercased()) {
                filteredCounties[pair.key] = pair.value
            }
        }
        
        for pair in counties {
            for county in pair.value {
                if county.name.lowercased().contains(text.lowercased()) {
                    if filteredCounties[pair.key] == nil {
                        filteredCounties[pair.key] = [county]
                    } else {
                        if !filteredCounties[pair.key]!.contains(county) {
                            filteredCounties[pair.key]!.append(county)
                        }
                    }
                }
            }
        }
        
        return (filteredCounties, Array(filteredCounties.keys))
    }
    
}
