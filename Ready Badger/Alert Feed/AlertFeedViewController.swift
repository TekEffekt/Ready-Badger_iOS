//
//  AlertFeedViewController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/3/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class AlertFeedViewController: UIViewController, DefaultTheme, MenuItem {
    
    var pageMenu: CAPSPageMenu?
    var alertFeeds: [FeedPageViewController]!
    var menu: HamburgerMenu?
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAlertFeeds()
        
        NetworkQueue.shared.addOperation(AllCountyOperation(withRequest: AllCountyRequest()))
    }
    
    private func downloadFeedData() {
        HackFeedGather.gather { (items) in
            let countyFeed = self.alertFeeds[0]
            let typeFeed = self.alertFeeds[1]
            countyFeed.feedData = self.splitItemsByCounty(items: items)
            typeFeed.feedData = self.splitItemsByType(items: items)
            countyFeed.keyList = Array(countyFeed.feedData.keys)
            typeFeed.keyList = Array(typeFeed.feedData.keys)
            countyFeed.newData = true
            typeFeed.newData = true
            OperationQueue.main.addOperation({ 
                self.loadingIndicator.stopAnimating()
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        downloadFeedData()
        loadingIndicator.startAnimating()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if pageMenu == nil {
            setupPageMenu()
        }
    }
    
    private func loadAlertFeeds() {
        let countyFeed = storyboard?.instantiateViewController(withIdentifier: "AlertFeedPage") as! FeedPageViewController
        let typeFeed = storyboard?.instantiateViewController(withIdentifier: "AlertFeedPage") as! FeedPageViewController
        countyFeed.title = "County"
        typeFeed.title = "Type"
        typeFeed.type = .type
        countyFeed.type = .county
        alertFeeds = [countyFeed, typeFeed]
    }
    
    private func splitItemsByCounty(items: [CurrentWeatherItem]) -> [String: [CurrentWeatherItem]] {
        var result: [String: [CurrentWeatherItem]] = [:]
        for item in items {
            if result[item.countyName] == nil {
                result[item.countyName] = []
            }
            result[item.countyName]?.append(item)
        }
        return result
    }
    
    private func splitItemsByType(items: [CurrentWeatherItem]) -> [String: [CurrentWeatherItem]] {
        return ["Current Weather": items]
    }
    
    private func setupPageMenu() {
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.1),
            .scrollMenuBackgroundColor(UIColor.white),
            .selectedMenuItemLabelColor(UIColor.black),
            .selectionIndicatorColor(UIColor.tint()),
            .menuItemFont(UIFont.systemFont(ofSize: 14.6, weight: UIFontWeightMedium)),
            .menuHeight(40),
            .menuItemSeparatorColor(#colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1))
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: alertFeeds,
                                frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height),
                                pageMenuOptions: parameters)
        pageMenu!.view.backgroundColor = UIColor.clear
        
        self.edgesForExtendedLayout = UIRectEdge()
        self.view.addSubview(pageMenu!.view)
        view.insertSubview(pageMenu!.view, belowSubview: loadingIndicator)
    }
    
}
