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
        return "api/v0.5/damages"
    }
    
    var headers: [String : String]? {
        return ["RB-API-KEY" : "testhi", "Content-Type": "application/json"]
    }
    
    var parameters: [Parameter]? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let type = DisasterType.getAll().index(of: report.disasterType!) as AnyObject
        let dateString = formatter.string(from: report.date) as AnyObject
        let name = report.name as AnyObject
        let address = report.address as AnyObject
        let city = report.city as AnyObject
        let state = report.state as AnyObject
        let zipCode = Int(report.zipCode ?? "") as AnyObject
        let phoneNumber = Int(report.phoneNumber ?? "") as AnyObject
        let ownership = (report.ownership == .yes ? 1 : 0) as AnyObject
        let insuranceCoverage = report.percentOfLoss as AnyObject
        let insuranceDeductible = report.insuranceDeductible as AnyObject
        let lossEstimate = report.damageEstimate as AnyObject
        let habitable = (report.residenceIsHabitable == .yes ? 1 : 0) as AnyObject
        let basementWater = (report.basementFlooded == .yes ? 1 : 0) as AnyObject
        let basementOccupant = (report.personLivingInBasement == .yes ? 1 : 0) as AnyObject
        let description = (report.description == nil ? "" : report.description) as AnyObject
        let waterDepth = (report.inchesOfWater == nil ? "0" : report.inchesOfWater) as AnyObject
        let albumID = ((albumId == nil) ? "NULL": albumId) as AnyObject
        let latitude =  50.72 as AnyObject
        let longitude = 21.825 as AnyObject
        let deviceId = "Unknown" as AnyObject
        
        let keyValueList = ["date" : dateString, "type" : type, "reporterName": name, "address": address, "city": city, "state": state, "zipcode": zipCode, "reporterPhone": phoneNumber, "owned": ownership, "description": description, "lossEstimation": lossEstimate, "insuranceCoverage": insuranceCoverage, "insuranceDeductible": insuranceDeductible, "habitable": habitable, "basementWater": basementWater, "basementOccupant": basementOccupant, "latitude": latitude, "longitude": longitude, "images": albumID, "waterDepth": waterDepth, "deviceID": deviceId]
        let params = keyValueList.map() {(key, value) in return Parameter(Key: key, Value: value)}
        
        return params
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
