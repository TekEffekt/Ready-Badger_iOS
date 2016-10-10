//
//  BackendService.swift
//  Safety Survey
//
//  Created by Kyle Zawacki on 8/22/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class BackendService {
    
    private let backendConfiguration: BackendConfiguration
    private var networkTask: URLSessionDataTask?
    
    init(config backendConfig: BackendConfiguration) {
        backendConfiguration = backendConfig
    }
    
    func request(with request: BackendRequest, success: @escaping ((NSData) -> Void),
                      failure: @escaping ((NSError) -> Void)) {
        let url = backendConfiguration.baseUrl.appendingPathComponent(request.endpoint)
        let urlRequest = NSMutableURLRequest(url: url!)
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpMethod = request.method.rawValue
        
        if let params = request.parameters {
            urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
        }
        
        let session = URLSession.shared
        networkTask = session.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, response, error) in
            if data != nil && error == nil {
                success(data! as NSData)
            } else {
                failure(error! as NSError)
            }
        })
        
        print(urlRequest.url)
        
        networkTask?.resume()
    }
    
    func generateBoundaryString() -> String
    {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func cancel() {
        networkTask?.cancel()
    }
}
