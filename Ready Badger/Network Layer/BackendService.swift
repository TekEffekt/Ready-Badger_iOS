//
//  BackendService.swift
//  Safety Survey
//
//  Created by Kyle Zawacki on 8/22/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import RealReachability

class BackendService {
    
    private let backendConfiguration: BackendConfiguration
    private var networkTask: URLSessionDataTask?
    
    init(config backendConfig: BackendConfiguration) {
        backendConfiguration = backendConfig
    }
    
    func request(with request: BackendRequest, success: @escaping ((NSData) -> Void),
                      failure: @escaping ((NSError) -> Void)) {
        guard RealReachability.sharedInstance().currentReachabilityStatus() != .RealStatusNotReachable else {
            NetworkAlert.show()
            return
        }
        
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
                    urlRequest.httpBody = buildJson(withParameters: params)
                }
            } else {
                let newUrlString = "\(urlRequest.url!.absoluteString)\(getQueryStringFor(parameters: params))"
                urlRequest.url = URL(string: newUrlString)!
            }
        }
        
        LoadingIndicator.showIndicator()
        
        let session = URLSession.shared
        networkTask = session.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, response, error) in
            LoadingIndicator.hideIndicator()
            print("Response :\(response)")
            if data != nil && error == nil {
                success(data! as NSData)
            } else {
                failure(error! as NSError)
            }
        })
        
        networkTask?.resume()
    }
    
    func buildJson(withParameters parameters: [Parameter]) -> Data {
        let jsonData = NSMutableData()
        jsonData.appendString(string: "{")
        var mutable = parameters
        let first = mutable.removeFirst()
        jsonData.appendString(string: "\"\(first.Key)\": \"\(first.Value)\"")
        for param in mutable {
            jsonData.appendString(string: ",\"\(param.Key)\": \"\(param.Value)\"")
        }
        jsonData.appendString(string: "}")
        print(NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue))
        
        return jsonData as Data
    }
    
    func getQueryStringFor(parameters: [Parameter]) -> String {
        var string = "?"
        for param in parameters {
            string += "\(param.Key)=\(param.Value)&"
        }
        return string
    }
    
    func httpBodyWithParameters(parameters: [Parameter]?, imageData: Data, boundary: String) -> Data {
        let body = NSMutableData()
                
        // create a line for each parameter
        if let params = parameters {
            for param in params {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(param.Key)\"\r\n\r\n")
                body.appendString(string: "\(param.Value)\r\n")
            }
        }
        
        // add image data to the body
        let mimetype = "image/jpeg"
        
        let filename = "image.jpg"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"image\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageData)
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
