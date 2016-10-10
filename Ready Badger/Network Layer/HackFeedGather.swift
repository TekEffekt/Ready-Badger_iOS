//
//  HackFeedGather.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/10/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

class HackFeedGather {
    
    static func gather(completionBlock: @escaping (([CurrentWeatherItem]) -> Void)) {
        
        NetworkQueue.shared.addOperation {
            let counties = CountyQueries.getAllSelectedCounties()
            var items = [CurrentWeatherItem]()
            for county in counties {
                let urlString = "http://readybadger.org/api/index.php/RSS/currentWeather/RB-API-KEY/testhi/currentWeatherCode/\(county.currentWeatherCode)"
                let request = URLRequest(url: NSURL(string: urlString) as! URL)
                let data = try! NSURLConnection.sendSynchronousRequest(request, returning: nil)
                let json = try! JSONSerialization.jsonObject(with: data as Data, options:JSONSerialization.ReadingOptions(rawValue: 0))
                guard let array = json as? NSDictionary else {
                    return
                }
                
                items.append(CurrentWeatherItem(title: array.value(forKey: "title") as! String, description: array.value(forKey: "description") as! String, countyName: county.name))
            }
            
            completionBlock(items)
        }
    }
    
}
