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
        
        let generalMinLengthRule = ValidationRuleLength(min: 1, failureError: ValidationError(message: "is empty"))
        let generalMaxLengthRule = ValidationRuleLength(max: 100, failureError: ValidationError(message: "must have less than 100 characters"))
        let digitRule = ValidationRulePattern(pattern: .ContainsNumber, failureError: ValidationError(message: "must have only digits."))
        let phoneSizeRule = ValidationRuleLength(min: 10, max: 11, failureError: ValidationError(message: "must have between 10 and 11 digits."))
        let zipCodeRule = ValidationRulePattern(pattern: .USPostcode, failureError: ValidationError(message: "Invalid zip code"))
        
        let defaultSet = ValidationRuleSet(rules: [generalMinLengthRule, generalMaxLengthRule])
        var phoneSet = ValidationRuleSet(rules: [phoneSizeRule])
        phoneSet.add(rule: digitRule)
        var numberSet = ValidationRuleSet(rules: [generalMinLengthRule, generalMaxLengthRule])
        numberSet.add(rule: digitRule)
        let nameCheck = Validator.validate(input: report.name, rules: defaultSet)
        let disasterCheck = Validator.validate(input: report.disasterType?.rawValue, rules: defaultSet)
        let phoneCheck = Validator.validate(input: report.phoneNumber, rules: phoneSet)
        let addressCheck = Validator.validate(input: report.address, rules: defaultSet)
        let cityCheck = Validator.validate(input: report.city, rules: defaultSet)
        let stateCheck = Validator.validate(input: report.state ?? "", rules: defaultSet)
        let zipCheck = Validator.validate(input: report.zipCode, rule: zipCodeRule)
        let ownershipCheck = Validator.validate(input:  report.ownership.rawValue, rules: defaultSet)
        let deductibleCheck = Validator.validate(input: report.insuranceDeductible, rules: numberSet)
        let lossCheck = Validator.validate(input: report.percentOfLoss, rules: numberSet)
        let estimateCheck = Validator.validate(input: report.damageEstimate, rules: numberSet)
        let habitableCheck = Validator.validate(input: report.residenceIsHabitable.rawValue, rules: defaultSet)
        let inchesCheck = Validator.validate(input: report.inchesOfWater, rules: defaultSet)
        let livingCheck = Validator.validate(input: report.personLivingInBasement.rawValue, rules: defaultSet)

        switch disasterCheck {
        case .invalid(let failures): errorMessages[DamageReportCellType.disasterType] = failures.map() {item in return "Disaster type " + item.message}
        default: break
        }
        
        switch nameCheck {
        case .invalid(let failures): errorMessages[DamageReportCellType.name] = failures.map() {item in return "Your name " + item.message}
            default: break
        }
        
        switch phoneCheck {
        case .invalid(let failures): errorMessages[DamageReportCellType.phoneNumber] = failures.map() {item in return "Your phone number " + item.message}
        default: break
        }
        
        switch addressCheck {
        case .invalid(let failures): errorMessages[DamageReportCellType.address] = failures.map() {item in return "Your address " +  item.message}
        default: break
        }
        
        switch cityCheck {
        case .invalid(let failures): errorMessages[DamageReportCellType.city] = failures.map() {item in return "Your city " + item.message}
        default: break
        }
        
        switch stateCheck {
        case .invalid(let failures): errorMessages[DamageReportCellType.state] = failures.map() {item in return "Your state " + item.message}
        default: break
        }
        
        switch zipCheck {
        case .invalid(let failures): errorMessages[DamageReportCellType.zipCode] = failures.map() {item in return item.message}
        default: break
        }
        
        switch ownershipCheck {
        case .invalid(let failures): errorMessages[DamageReportCellType.ownership] = failures.map() {item in return "Ownership " + item.message}
        default: break
        }
        
        switch deductibleCheck {
        case .invalid(let failures): errorMessages[DamageReportCellType.insuranceDeductible] = failures.map() {item in return "Your deductible " + item.message}
        default: break
        }
        
        switch lossCheck {
        case .invalid(let failures): errorMessages[DamageReportCellType.percentLoss] = failures.map() {item in return "Your percent loss " + item.message}
        default: break
        }
        
        switch estimateCheck {
        case .invalid(let failures): errorMessages[DamageReportCellType.damageEstimate] = failures.map() {item in return "Your estimate " + item.message}
        default: break
        }
        
        switch habitableCheck {
        case .invalid(let failures): errorMessages[DamageReportCellType.residenceHabitable] = failures.map() {item in return "Residence is habitable " + item.message}
        default: break
        }
        
        if report.basementFlooded == .yes {
            switch inchesCheck {
            case .invalid(let failures): errorMessages[DamageReportCellType.waterInches] = failures.map() {item in return "Inches of water " + item.message}
            default: break
            }
            
            switch livingCheck {
            case .invalid(let failures): errorMessages[DamageReportCellType.livingInBasement] = failures.map() {item in return "Living in basement " + item.message}
            default: break
            }
        }
        
        print(errorMessages)
                
        return errorMessages
    }
    
}
