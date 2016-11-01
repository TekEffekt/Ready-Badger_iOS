//
//  DamageReportInputValidator.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/31/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import Validator

class DamageReportValidator {
    
    static func validate(report: DamageReport) -> [DamageReportCellType: [String]] {
        var errorMessages = [DamageReportCellType: [String]]()
        
        let generalMinLengthRule = ValidationRuleLength(min: 1, failureError: ValidationError(message: "must have more than 1 character"))
        let generalMaxLengthRule = ValidationRuleLength(max: 100, failureError: ValidationError(message: "must have less than 100 characters"))
        let digitRule = ValidationRulePattern(pattern: .ContainsNumber, failureError: ValidationError(message: "must have less than 100 characters"))
        let phoneSizeRule = ValidationRuleLength(min: 10, max: 11, failureError: ValidationError(message: "Your phone number must have between 10 and 11 digits."))
        let zipCodeRule = ValidationRulePattern(pattern: .UKPostcode, failureError: ValidationError(message: "Invalid zip code"))
        
        let defaultSet = ValidationRuleSet(rules: [generalMinLengthRule, generalMaxLengthRule])
        var phoneSet = ValidationRuleSet(rules: [digitRule])
        phoneSet.add(rule: phoneSizeRule)
        var numberSet = ValidationRuleSet(rules: [generalMinLengthRule, generalMaxLengthRule])
        numberSet.add(rule: digitRule)
        let nameCheck = Validator.validate(input: report.name, rules: defaultSet)
        let phoneCheck = Validator.validate(input: report.phoneNumber, rules: phoneSet)
        let addressCheck = Validator.validate(input: report.address, rules: defaultSet)
        let cityCheck = Validator.validate(input: report.city, rules: defaultSet)
        let zipCheck = Validator.validate(input: report.zipCode, rule: zipCodeRule)
        let deductibleCheck = Validator.validate(input: report.insuranceDeductible, rules: numberSet)
        let lossCheck = Validator.validate(input: report.insuranceDeductible, rules: numberSet)
        let estimateCheck = Validator.validate(input: report.insuranceDeductible, rules: numberSet)

        switch nameCheck {
        case .invalid(let failures): errorMessages[DamageReportCellType.name] = failures.map() {item in return "Your name " + item.message}
            default: break
        }
        
        switch phoneCheck {
        case .invalid(let failures): errorMessages[DamageReportCellType.phoneNumber] = failures.map() {item in return item.message}
        default: break
        }
        
        switch addressCheck {
        case .invalid(let failures): errorMessages[DamageReportCellType.address] = failures.map() {item in return item.message}
        default: break
        }
        
        switch cityCheck {
        case .invalid(let failures): errorMessages[DamageReportCellType.city] = failures.map() {item in return item.message}
        default: break
        }
        
        switch zipCheck {
        case .invalid(let failures): errorMessages[DamageReportCellType.zipCode] = failures.map() {item in return item.message}
        default: break
        }
        
        switch deductibleCheck {
        case .invalid(let failures): errorMessages[DamageReportCellType.insuranceDeductible] = failures.map() {item in return item.message}
        default: break
        }
        
        switch lossCheck {
        case .invalid(let failures): errorMessages[DamageReportCellType.percentLoss] = failures.map() {item in return item.message}
        default: break
        }
        
        switch estimateCheck {
        case .invalid(let failures): errorMessages[DamageReportCellType.damageEstimate] = failures.map() {item in return item.message}
        default: break
        }
        
        print(errorMessages)
                
        return errorMessages
    }
    
}
