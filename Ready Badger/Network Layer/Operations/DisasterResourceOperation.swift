//
//  DisasterResourceOperation.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/13/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class DisasterResourceOperation: Operation, BackendOperation {
    
    var service: BackendService = BackendService(config: BackendConfiguration.shared)
    var request: BackendRequest
    
    var handleSuccess: ((NSData) -> Void) {
        return { data in
            do {
                let json = try JSONSerialization.jsonObject(with: data as Data, options:JSONSerialization.ReadingOptions(rawValue: 0))
                guard let array = json as? NSArray else {
                    return
                }
                
                DisasterResourceParse.parse(data: array)
                UserDefaults.standard.set(true, forKey: "Resources Downloaded")
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
    
    init(withRequest request: DisasterResourceRequest) {
        self.request = request
        super.init()
    }
    
    override func start() {
        super.start()
        service.request(with: request, success: handleSuccess, failure: handleFailure)
    }
    
}
