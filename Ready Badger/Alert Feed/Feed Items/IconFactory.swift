//
//  IconFactory.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/20/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import UIKit

class IconFactory {
    
    static func getWeatherIcon(text: String) -> UIImage {
        let lower = text.lowercased()
    
        if (lower.contains("fair") || lower.contains("clear")) {
            return #imageLiteral(resourceName: "Sunny")
        } else if (lower.contains("cloudy")) {
            return #imageLiteral(resourceName: "Cloudy")
        } else if (lower.contains("overcast")) {
            return #imageLiteral(resourceName: "Overcast")
        } else if (lower.contains("fog") || lower.contains("smoke")) {
            return #imageLiteral(resourceName: "Foggy")
        } else if (lower.contains("rain") || lower.contains("shower")) {
            return #imageLiteral(resourceName: "Rainy")
        } else if (lower.contains("storm") || lower.contains("thunder")) {
            return #imageLiteral(resourceName: "Stormy")
        } else if (lower.contains("wind") || lower.contains("breezy")) {
            return #imageLiteral(resourceName: "Windy")
        } else if (lower.contains("snow") || lower.contains("ice")) {
            return #imageLiteral(resourceName: "Snowing")
        } else if (lower.contains("tornado") || lower.contains("spout") || lower.contains("funnel")) {
            return #imageLiteral(resourceName: "Tornado")
        } else {
            return #imageLiteral(resourceName: "Sunny")
        }
    }
    
    static func getRoadIcon(text: String) -> UIImage {
        let lower = text.lowercased()
        if lower.contains("good") {
            return #imageLiteral(resourceName: "Good Road")
        } else if lower.contains("bad") {
            return #imageLiteral(resourceName: "Bad Road")
        } else {
            return #imageLiteral(resourceName: "Bad Road")
        }
    }
    
    static func getAirQualityIcon(text: String) -> UIImage {
        let lower = text.lowercased()
        
        return #imageLiteral(resourceName: "Good Air Quality")
    }

}
