//
//  BackendOperation.swift
//  Safety Survey
//
//  Created by Kyle Zawacki on 8/23/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

protocol BackendOperation {
    var service: BackendService { get }
    var request: BackendRequest { get }
    var handleSuccess: ((NSData) -> Void) { get }
    var handleFailure: ((NSError) -> Void) { get }
}
