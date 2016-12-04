//
//  BackendConfiguration.swift
//  Safety Survey
//
//  Created by Kyle Zawacki on 8/22/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class BackendConfiguration {
    
    let baseUrl: NSURL
    static var shared: BackendConfiguration = BackendConfiguration(urlString: "http://readybadger.org")
    
    init(urlString: String) {
        baseUrl = NSURL(string: urlString) ?? NSURL()
    }
}
