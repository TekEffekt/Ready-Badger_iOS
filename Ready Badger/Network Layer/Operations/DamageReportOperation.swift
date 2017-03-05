//
//  DamageReportOperation.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/14/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class DamageReportOperation: Operation, BackendOperation {
    
    var service: BackendService = BackendService(config: BackendConfiguration.shared)
    var request: BackendRequest
    
    var handleSuccess: ((NSData) -> Void) {
        return { data in
            do {
                ReportAlert.show()
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
    
    init(withRequest request: DamageReportRequest) {
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
    
