//
//  AlertFeedViewController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/3/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit
import MBProgressHUD

class AlertFeedViewController: UIViewController, DefaultTheme, MenuItem {
    
    var pageMenu: CAPSPageMenu?
    var alertFeeds: [FeedPageViewController]!
    var menu: HamburgerMenu?
    var loadingIndicator: MBProgressHUD?
    var emptyState: EmptyState?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAlertFeeds()        
    }
    
    private func setEmptyState(on: Bool) {
        if emptyState == nil {
            emptyState = Bundle.loadView(fromNib: "EmptyState", withType: EmptyState.self)
            emptyState?.center = CGPoint(x: view.center.x, y: 180)
            view.addSubview(emptyState!)
        }
        
        emptyState?.isHidden = !on
    }
    
    private func downloadFeedData() {
        guard CountyQueries.getAllSelectedCounties().count > 0 else { return }
        loadingIndicator = MBProgressHUD.showAdded(to: navigationController!.view, animated: true)
        loadingIndicator?.label.text = "Loading.."
        loadingIndicator?.isUserInteractionEnabled = false
        NetworkQueue.shared.addOperation(FeedOperation(withRequest: FeedRequest(), completionHandler: { (feedData) in
            OperationQueue.main.addOperation({
                self.loadingIndicator?.hide(animated: true)

                for vc in self.alertFeeds {
                    vc.feedData = feedData
                }
            })
        }))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        downloadFeedData()
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
        typeFeed.type = .byType
        countyFeed.type = .byCounty
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
