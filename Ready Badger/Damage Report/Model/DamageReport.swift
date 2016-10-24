//
//  DamageReport.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/23/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

struct DamageReport {
    
    var disasterType: DisasterType?
    var date: NSDate?
    var name: String?
    var address: String?
    var state: String?
    var zipCode: String?
    var phoneNumber: String?
    var ownership: Answer = .n_a
    var insuranceDeductible: String?
    var percentOfLoss: String?
    var damageEstimate: String?
    var residenceIsHabitable: Answer = .n_a
    var basementFlooded: Answer = .n_a
    var personLivingInBasement: Answer = .n_a
    var inchesOfWater: String?
    var description: String?
    
}
