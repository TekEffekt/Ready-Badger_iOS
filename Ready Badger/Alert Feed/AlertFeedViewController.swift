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
    var emptyState: EmptyStateView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAlertFeeds()
    }
    
    private func downloadFeedData() {
        guard CountyQueries.getAllSelectedCounties().count > 0 else {
            if emptyState != nil {
                emptyState.isHidden = false
            }
            for vc in self.alertFeeds {
                vc.feedData = nil
            }
            return
        }
        loadingIndicator = MBProgressHUD.showAdded(to: navigationController!.view, animated: true)
        loadingIndicator?.label.text = "Loading.."
        loadingIndicator?.isUserInteractionEnabled = false
        NetworkQueue.shared.addOperation(FeedOperation(withRequest: FeedRequest(), completionHandler: { (feedData) in
            OperationQueue.main.addOperation({
                self.loadingIndicator?.hide(animated: true)

                for vc in self.alertFeeds {
                    vc.feedData = feedData
                }
                
                self.emptyState.isHidden =
                    feedData.getSectionNumber(withOrientation: .byCounty) > 0 ? true : false
            })
        }))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        downloadFeedData()
    }
    
    private func setupEmptyState() {
        emptyState = EmptyStateView(parentView: view, image: #imageLiteral(resourceName: "Empty State"), primaryText: "No County Data", secondaryText: "Hit the settings button to subscribe.")
        view.addSubview(emptyState)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if pageMenu == nil {
            setupPageMenu()
            setupEmptyState()
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
        
        self.edgesForExtendedLayout = UIRectEdge()
        self.view.addSubview(pageMenu!.view)
    }
    
}
