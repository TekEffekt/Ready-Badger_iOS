//
//  DamgeReportImageRequest.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/27/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

struct DamageReportImageRequest: BackendRequest {
    
    let imageData: Data?
    let albumId: String
    
    var headers: [String : String]? {
        return ["X-API-KEY" : "c7crds7c3b2xqzdx0g4dnnld2tvr76re", "Accept": "applications/json",
                "Content-Type": "multipart/form-data; boundary=\(BoundaryString.get())"]
    }
    
    var endpoint: String {
        return "images"
    }
    
    var method: BackendServiceMethod {
        return .POST
    }
    
    var alernativeUrl: URL? {
        return URL(string: "http://imageserver.appfactoryuwp.com")
    }
    
    var parameters: [String : AnyObject]? {
        return ["albumid": albumId as AnyObject]
    }
    
    //, "title": "NULL" as AnyObject, "description": "NULL" as AnyObject
    
    init(imageData: Data?, albumId: String) {
        self.imageData = imageData
        self.albumId = albumId
    }
    
}
