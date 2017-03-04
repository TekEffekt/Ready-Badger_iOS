//
//  AllCountyOperation.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/9/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class AllCountyOperation: Operation, BackendOperation {
    
    var service: BackendService = BackendService(config: BackendConfiguration.shared)
    var request: BackendRequest
    
    var handleSuccess: ((NSData) -> Void) {
        return { data in
            do {
                let JSON = try JSONSerialization.jsonObject(with: data as Data, options:JSONSerialization.ReadingOptions(rawValue: 0))
                guard let array = JSON as? NSArray else {
                    return
                }
                
                CountyDataParse.parse(data: array)
                UserDefaults.standard.set(true, forKey: "Counties Downloaded")
            } catch _ {
                print("JSON Invalid")
            }
        }
    }
    
    var handleFailure: ((NSError) -> Void) {
        return {error in
            print(error)
        }
    }
    
    init(withRequest request: AllCountyRequest) {
        self.request = request
        super.init()
    }
    
    override func start() {
        super.start()
        service.request(with: request, success: handleSuccess, failure: handleFailure)
    }
    
    override func cancel() {
        super.cancel()
        service.cancel()
    }

}
