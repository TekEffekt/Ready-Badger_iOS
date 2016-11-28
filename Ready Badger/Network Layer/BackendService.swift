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
        let url: URL
        if let alernativeUrl = request.alernativeUrl {
            url = alernativeUrl.appendingPathComponent(request.endpoint)
        } else {
            url = backendConfiguration.baseUrl.appendingPathComponent(request.endpoint)!
        }
        let urlRequest = NSMutableURLRequest(url: url)
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpMethod = request.method.rawValue
        
        if let params = request.parameters {
            if request.method == .POST {
                if let imageData = request.imageData {
                    urlRequest.httpBody = httpBodyWithParameters(parameters: params, imageData: imageData as Data, boundary: BoundaryString.get())
                } else {
                    urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
                }
            } else {
                let newUrlString = "\(urlRequest.url!.absoluteString)\(getQueryStringFor(parameters: params))"
                urlRequest.url = URL(string: newUrlString)!
            }
        }
        
        let session = URLSession.shared
        networkTask = session.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, response, error) in
            if data != nil && error == nil {
                success(data! as NSData)
            } else {
                failure(error! as NSError)
            }
        })
        
        networkTask?.resume()
    }
    
    func getQueryStringFor(parameters: [String: AnyObject]) -> String {
        var string = "?"
        for param in parameters {
            string += "\(param.value)=\(param.key)&"
        }
        return string
    }
    
    func httpBodyWithParameters(parameters: [String: AnyObject]?, imageData: Data, boundary: String) -> Data {
        let body = NSMutableData()
        
        // create a line for each paraneter
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        // add image data to the body
        let mimetype = "image/jpeg"
        
        let filename = "image.jpg"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"image\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageData as Data)
        body.appendString(string: "\r\n")
        
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body as Data
    }
    
    func cancel() {
        networkTask?.cancel()
    }
    
}

extension NSMutableData {
    
    // clean function to turn a string into data
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
