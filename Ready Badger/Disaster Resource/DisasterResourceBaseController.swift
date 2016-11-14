//
//  DisasterResourceBaseController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/13/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class DisasterResourceBaseController: UIViewController, MenuItem {

    var menu: HamburgerMenu?
    var pageMenu: CAPSPageMenu?
    var resourcePages: [DisasterResourcePageController] {
        var pages: [DisasterResourcePageController] = []
        for type in DisasterResourceQuery.getResources() {
            let page = storyboard?.instantiateViewController(withIdentifier: "Resource Page") as! DisasterResourcePageController
            page.resources = type.value
            page.title = type.key
            pages.append(page)
        }
        return pages
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if pageMenu == nil {
            setupPageMenu()
        }
    }
    
    private func setupPageMenu() {
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .useMenuLikeSegmentedControl(false),
            .menuItemSeparatorPercentageHeight(0.1),
            .scrollMenuBackgroundColor(UIColor.white),
            .selectedMenuItemLabelColor(UIColor.black),
            .selectionIndicatorColor(UIColor.tint()),
            .menuItemFont(UIFont.systemFont(ofSize: 14.6, weight: UIFontWeightMedium)),
            .menuHeight(40),
            .menuItemSeparatorColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
            .menuItemWidthBasedOnTitleTextWidth(true)
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: resourcePages,
                                frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height),
                                pageMenuOptions: parameters)
        pageMenu!.view.backgroundColor = UIColor.clear
        
        self.edgesForExtendedLayout = UIRectEdge()
        self.view.addSubview(pageMenu!.view)
        view.addSubview(pageMenu!.view)
    }

}
