//
//  ImageAlbumRequest.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/27/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

struct ImageAlbumRequest: BackendRequest {
    
    var imageData: Data?
    
    var headers: [String : String]? {
        return ["X-API-KEY" : "c7crds7c3b2xqzdx0g4dnnld2tvr76re", "Accept": "applications/json",
        "Content-Type": "multipart/form-data; boundary=\(BoundaryString.get())"]
    }
    
    var endpoint: String {
        return "albums"
    }
    
    var method: BackendServiceMethod {
        return .POST
    }
    
    var alernativeUrl: URL? {
        return URL(string: "http://imageserver.appfactoryuwp.com")
    }
    
    var parameters: [String : AnyObject]? {
        return nil
    }
    
    init(withImageData imageData: Data?) {
        self.imageData = imageData
    }
    
}

