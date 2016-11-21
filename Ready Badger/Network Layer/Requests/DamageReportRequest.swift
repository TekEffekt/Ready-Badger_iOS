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
    
    var endpoint: String {
        return "api/damages"
    }
    
    var headers: [String : String]? {
        return ["RB-API-KEY" : "testhi"]
    }
    
    var parameters: [String : AnyObject]? {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        let type = DisasterType.getAll().index(of: report.disasterType!) as AnyObject
        let ownership = (report.ownership == .yes ? 1 : 0) as AnyObject
        let habitable = (report.residenceIsHabitable == .yes ? 1 : 0) as AnyObject
        let basementWater = (report.basementFlooded == .yes ? 1 : 0) as AnyObject
        let basementOccupant = (report.personLivingInBasement == .yes ? 1 : 0) as AnyObject
        let dateString = formatter.string(from: report.date) as AnyObject
        
        return ["date" : dateString, "type" : type, "reportername": report.name as AnyObject, "address": report.address as AnyObject, "city": report.city as AnyObject, "zipcode": Int(report.zipCode ?? "") as AnyObject, "reporterPhone": Int(report.phoneNumber ?? "") as AnyObject, "owned": ownership, "description": report.description as AnyObject, "lossEstimation": report.damageEstimate as AnyObject, "insuranceCoverage": report.percentOfLoss as AnyObject, "insuranceDeductible": report.insuranceDeductible as AnyObject, "habitable": habitable, "basementWater": basementWater, "basementOccupant": basementOccupant, "latitude": 50.72 as AnyObject, "longitude": 21.825 as AnyObject, "images": 0 as AnyObject, "waterDepth": report.inchesOfWater as AnyObject, "deviceID": "Unknown" as AnyObject]
    }
    
    var method: BackendServiceMethod {
        return .POST
    }
    
    var imageData: NSData? {
        return nil
    }
    
    init(withReport report: DamageReport) {
        self.report = report
    }
}
