//
//  FeedPageViewController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/3/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class FeedPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var type: FeedOrientation!
    @IBOutlet weak var feedTable: UITableView!
    var feedData: FeedData? {
        didSet {
            newData = true
        }
    }
    var newData: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTable.dataSource = self
        feedTable.delegate = self
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.reloadTimer), userInfo: nil, repeats: true)
    }
    
    func reloadTimer() {
        if (self.feedTable != nil) && newData {
            self.feedTable.reloadData()
            newData = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        feedTable.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let data = feedData else { return 0 }
        return data.getSectionNumber(withOrientation: type)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = feedData else { return 0 }
        return data.getRowNumber(withOrientation: type, forSection: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return feedData?.getHeader(forSection: section, withOrientation: type)
    }
    
    func getWeatherCell(forData data: WeatherData, andCellTitle cellTitle: String?) -> WeatherTableViewCell {
        let cell = feedTable.dequeueReusableCell(withIdentifier: "Weather Cell") as! WeatherTableViewCell
        if let cellTitle = cellTitle {
            cell.countyLabel.text = cellTitle
        }
        cell.titleLabel.text = data.title
        //cell.descriptionLabel.text = data.description
        cell.weatherIcon.image = IconFactory.getWeatherIcon(text: data.title)
        return cell
    }
    
    func getRoadCell(forData data: RoadData, andCellTitle cellTitle: String?) -> RoadIncidentTableViewCell {
        let cell = feedTable.dequeueReusableCell(withIdentifier: "Road Incident Cell") as! RoadIncidentTableViewCell
        if let cellTitle = cellTitle {
            cell.countyLabel.text = cellTitle
        }
        cell.roadIcon.image = IconFactory.getRoadIcon(text: data.severity)
        cell.titleLabel.text = data.title
        cell.descriptionLabel.text = "\(data.roadwayName), \(data.location), \(data.travelDirection)"
        cell.lanesAffectedLabel.text = "Lanes Affected: \(data.lanesAffected)"
        
        return cell
    }
    
    func getAlertCell(forData data: AlertData, andCellTitle cellTitle: String?) -> AlertTableViewCell {
        let cell = feedTable.dequeueReusableCell(withIdentifier: "Alert Cell") as! AlertTableViewCell
        if let cellTitle = cellTitle {
            cell.countyLabel.text = cellTitle
        }
        cell.titleLabel.text = data.title
        cell.descriptionLabel.text = data.description
        return cell
    }
    
    func getAirQualityCell(forData data: AirQualityData, andCellTitle cellTitle: String?) -> AirQualityTableViewCell {
        let cell = feedTable.dequeueReusableCell(withIdentifier: "Air Quality Cell") as! AirQualityTableViewCell
        if let cellTitle = cellTitle {
            cell.countyLabel.text = cellTitle
        }
        cell.airIcon.image = IconFactory.getAirQualityIcon(text: data.title)
        cell.titleLabel.text = data.title
        cell.descriptionLabel.text = data.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let feedData = feedData else { return UITableViewCell() }
        let data = feedData.getData(forRow: indexPath.row, andSection: indexPath.section, withOrientation: type)
        let cellName = feedData.getCellTitle(forRow: indexPath.row, andSection: indexPath.section, withOrientation: type)
        if let weatherData = data as? WeatherData {
            return getWeatherCell(forData: weatherData, andCellTitle: cellName)
        } else if let roadData = data as? RoadData {
            return getRoadCell(forData: roadData, andCellTitle: cellName)
        } else if let alertData = data as? AlertData {
            return getAlertCell(forData: alertData, andCellTitle: cellName)
        } else if let airData = data as? AirQualityData {
            return getAirQualityCell(forData: airData, andCellTitle: cellName)
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = feedData?.getData(forRow: indexPath.row, andSection: indexPath.section, withOrientation: type)
        if data is RoadData {
            return 130
        } else if data is AlertData {
            return 125
        } else {
            return 140
        }
    }

}
