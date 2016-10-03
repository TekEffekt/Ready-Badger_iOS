//
//  AlertFeedViewController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/3/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class AlertFeedViewController: UIViewController, MenuItem {
    
    var pageMenu: CAPSPageMenu?
    var alertFeeds: [FeedPageViewController]!
    var menu: HamburgerMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAlertFeeds()
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
        alertFeeds = [countyFeed, typeFeed]
    }
    
    private func setupPageMenu() {
//        let parameters: [CAPSPageMenuOption] = [
//            .scrollMenuBackgroundColor(UIColor.white),
//            .menuItemSeparatorColor(#colorLiteral(red: 0.6235294118, green: 0.6235294118, blue: 0.6235294118, alpha: 1)),
//            .selectionIndicatorColor(UIColor.tint()),
//            .addBottomMenuHairline(true),
//            .menuHeight(40),
//            .menuItemFont(UIFont(name: "Avenir-Medium", size: 14)!),
//            .bottomMenuHairlineColor(UIColor.clear),
//            .selectedMenuItemLabelColor(UIColor.black),
//            .menuItemWidthBasedOnTitleTextWidth(false),
//            .centerMenuItems(true),
//            .menuItemSeparatorWidth(4.3),
//            .enableHorizontalBounce(true)
//        ]
        
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.1),
            .scrollMenuBackgroundColor(UIColor.white),
            .selectedMenuItemLabelColor(UIColor.black),
            .selectionIndicatorColor(UIColor.tint()),
            .menuItemFont(UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)),
            .menuHeight(40)
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: alertFeeds,
                                frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height),
                                pageMenuOptions: parameters)
        pageMenu!.view.backgroundColor = UIColor.clear
        
        self.edgesForExtendedLayout = UIRectEdge()
        self.view.addSubview(pageMenu!.view)
    }
}
