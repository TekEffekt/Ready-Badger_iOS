//
//  FeedOperation.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/18/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class FeedOperation: Operation, BackendOperation {
    
    var service: BackendService = BackendService(config: BackendConfiguration.shared)
    var request: BackendRequest
    var completionHandler: ((FeedData) -> Void)
    
    var handleSuccess: ((NSData) -> Void) {
        return { data in
            do {
                let json = try JSONSerialization.jsonObject(with: data as Data, options:JSONSerialization.ReadingOptions(rawValue: 0))
                guard let dictionary = json as? NSDictionary else {
                    return
                }
                let feedData = FeedParse.parse(data: dictionary)
                self.completionHandler(feedData)
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
    
    init(withRequest request: FeedRequest, completionHandler: @escaping ((FeedData) -> Void)) {
        self.request = request
        self.completionHandler = completionHandler
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
