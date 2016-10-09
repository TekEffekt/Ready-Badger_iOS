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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAlertFeeds()
        
        NetworkQueue.shared.addOperation(AllCountyOperation(withRequest: AllCountyRequest()))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
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
    }
    
}
