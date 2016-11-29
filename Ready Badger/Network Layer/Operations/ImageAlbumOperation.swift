//
//  ImageAlbumOperation.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/27/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class ImageAlbumOperation: Operation, BackendOperation {
    
    var service: BackendService = BackendService(config: BackendConfiguration.shared)
    var request: BackendRequest
    let damageReport: DamageReport
    
    var handleSuccess: ((NSData) -> Void) {
        return { data in
            do {
                let string = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)
                print(string)
                let json = try JSONSerialization.jsonObject(with: data as Data, options:JSONSerialization.ReadingOptions(rawValue: 0))
                guard let dictionary = ((json as? NSArray)?.firstObject as? NSDictionary) else {
                    return
                }
                
                let albumId = dictionary.value(forKey: "albumid") as! String
                if let imageData = (self.request as! ImageAlbumRequest).imageData {
                    NetworkQueue.shared.addOperation(DamageReportImageOperation(withRequest: DamageReportImageRequest(imageData: imageData, albumId: albumId)))
                }
                
                NetworkQueue.shared.addOperation(DamageReportOperation(withRequest: DamageReportRequest(withReport: self.damageReport, andAlbumId: albumId)))
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
    
    init(withRequest request: ImageAlbumRequest, andDamageReport damageReport: DamageReport) {
        self.request = request
        self.damageReport = damageReport
        super.init()
    }
    
    override func start() {
        super.start()
        service.request(with: request, success: handleSuccess, failure: handleFailure)
    }
    
}
