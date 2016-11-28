//
//  DamageReportRequest.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/14/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

struct DamageReportRequest: BackendRequest {
    
    let report: DamageReport
    let albumId: String?
    
    var endpoint: String {
        return "api/damages"
    }
    
    var headers: [String : String]? {
        return ["RB-API-KEY" : "testhi", "Content-Type": "application/json"]
    }
    
    var parameters: [String : AnyObject]? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let type = DisasterType.getAll().index(of: report.disasterType!) as AnyObject
        let ownership = (report.ownership == .yes ? 1 : 0) as AnyObject
        let habitable = (report.residenceIsHabitable == .yes ? 1 : 0) as AnyObject
        let basementWater = (report.basementFlooded == .yes ? 1 : 0) as AnyObject
        let basementOccupant = (report.personLivingInBasement == .yes ? 1 : 0) as AnyObject
        let dateString = formatter.string(from: report.date) as AnyObject
        let description = (report.description == nil ? "" : report.description) as AnyObject
        let waterDepth = (report.inchesOfWater == nil ? "0" : report.inchesOfWater) as AnyObject
        let albumID = ((albumId == nil) ? "NULL": albumId) as AnyObject
        
        return ["date" : dateString, "type" : type, "reporterName": report.name as AnyObject, "address": report.address as AnyObject, "city": report.city as AnyObject, "state": report.state as AnyObject, "zipcode": Int(report.zipCode ?? "") as AnyObject, "reporterPhone": Int(report.phoneNumber ?? "") as AnyObject, "owned": ownership, "description": description, "lossEstimation": report.damageEstimate as AnyObject, "insuranceCoverage": report.percentOfLoss as AnyObject, "insuranceDeductible": report.insuranceDeductible as AnyObject, "habitable": habitable, "basementWater": basementWater, "basementOccupant": basementOccupant, "latitude": 50.72 as AnyObject, "longitude": 21.825 as AnyObject, "images": albumID, "waterDepth": waterDepth, "deviceID": "Unknown" as AnyObject]
    }
    
    var method: BackendServiceMethod {
        return .POST
    }
    
    var imageData: Data? {
        return nil
    }
    
    init(withReport report: DamageReport, andAlbumId  albumId: String?) {
        self.report = report
        self.albumId = albumId
    }
    
    var alernativeUrl: URL? {
        return nil
    }
    
}
