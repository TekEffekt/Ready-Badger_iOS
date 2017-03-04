//
//  AlertFeedViewController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/3/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit
import OneSignal

class AlertFeedViewController: UIViewController, DefaultTheme, MenuItem, EmptyState {
    
    var pageMenu: CAPSPageMenu?
    var alertFeeds: [FeedPageViewController]!
    var menu: HamburgerMenu?
    var emptyState: EmptyStateView?
    var feedData: FeedData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAlertFeeds()
    }
    
    private func downloadFeedData() {
        guard CountyQueries.getAllSelectedCounties().count > 0 else {
            for vc in self.alertFeeds {
                vc.feedData = nil
            }
            configureEmptyState(ofType: .alert, hidden: false)
            return
        }
        
        NetworkQueue.shared.addOperation(FeedOperation(withRequest: FeedRequest(), completionHandler: { (feedData) in
            OperationQueue.main.addOperation({
                self.feedData = feedData
                print("County Data Count: \(feedData.countyData.count)")
                for vc in self.alertFeeds {
                    vc.feedData = feedData
                }
                
                self.checkIfEmpty()
            })
        }))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.frame = CGRect(x: view.frame.origin.x, y: 64, width: view.frame.width, height: view.frame.height)
        applyTheme()
        downloadFeedData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if pageMenu == nil {
            setupPageMenu()
        }
    }
    
    func checkIfEmpty() {
        var hidden = true
        if let data = feedData {
            hidden = !data.isEmpty
        } else {
            hidden = false
        }
        configureEmptyState(ofType: .alert, hidden: hidden)
    }
    
    private func loadAlertFeeds() {
        let countyFeed = storyboard?.instantiateViewController(withIdentifier: "AlertFeedPage") as! FeedPageViewController
        let typeFeed = storyboard?.instantiateViewController(withIdentifier: "AlertFeedPage") as! FeedPageViewController
        countyFeed.title = "County"
        typeFeed.title = "Type"
        typeFeed.type = .byType
        countyFeed.type = .byCounty
        alertFeeds = [countyFeed, typeFeed]
    }
    
    private func setupPageMenu() {
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.1),
            .scrollMenuBackgroundColor(UIColor.white),
            .selectedMenuItemLabelColor(UIColor.black),
            .selectionIndicatorColor(UIColor.tint()),
            .menuItemFont(UIFont.systemFont(ofSize: 14.6, weight: UIFontWeightMedium)),
            .menuHeight(40),
            .menuItemSeparatorColor(#colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)),
            .menuItemSeparatorRoundEdges(true)
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: alertFeeds,
                                frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height),
                                pageMenuOptions: parameters)
        pageMenu!.view.backgroundColor = UIColor.clear        
        if let emptyState = emptyState {
            view.insertSubview(pageMenu!.view, belowSubview: emptyState)
        } else {
            self.view.addSubview(pageMenu!.view)
        }
    }
    
}
