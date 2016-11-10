//
//  DisasterInfoViewController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/7/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit
import Segmentio

class DisasterInfoViewController: UIViewController, MenuItem {

    @IBOutlet weak var segmentController: Segmentio!
    @IBOutlet weak var webView: UIWebView!
    var menu: HamburgerMenu?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let htmlFile = Bundle.main.path(forResource: "flood", ofType: "html")
        let html = try? String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8)
        webView.loadHTMLString(html!, baseURL: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let item = SegmentioItem(title: "Wildfire", image: UIImage(named: "Wildfire"))
        let item2 = SegmentioItem(title: "Heat", image: UIImage(named: "Heat"))
        let item3 = SegmentioItem(title: "Flood", image: UIImage(named: "Flood Disaster"))
        let item4 = SegmentioItem(title: "Earthquake", image: UIImage(named: "Earthquake"))
        
        segmentController.setup(content: [item, item2, item3, item4], style: .imageOverLabel, options: segmentioOptions())
        segmentController.selectedSegmentioIndex = 0
    }
    
    func segmentioOptions() -> SegmentioOptions {
        let imageContentMode = UIViewContentMode.center

        return SegmentioOptions(
            backgroundColor: UIColor.white,
            maxVisibleItems: 3,
            scrollEnabled: true,
            indicatorOptions: segmentioIndicatorOptions(),
            horizontalSeparatorOptions: segmentioHorizontalSeparatorOptions(),
            verticalSeparatorOptions: segmentioVerticalSeparatorOptions(),
            imageContentMode: imageContentMode,
            labelTextAlignment: .center,
            segmentStates: segmentioStates()
        )
    }
    
    func segmentioStates() -> SegmentioStates {
        let font = UIFont.exampleAvenirMedium(ofSize: 13)
        return SegmentioStates(
            defaultState: segmentioState(
                backgroundColor: .white,
                titleFont: font,
                titleTextColor: UIColor.lightGray
            ),
            selectedState: segmentioState(
                backgroundColor: .white,
                titleFont: font,
                titleTextColor: .black
            ),
            highlightedState: segmentioState(
                backgroundColor: .white,
                titleFont: font,
                titleTextColor: .black
            )
        )
    }
    
    func segmentioState(backgroundColor: UIColor, titleFont: UIFont, titleTextColor: UIColor) -> SegmentioState {
        return SegmentioState(backgroundColor: backgroundColor, titleFont: titleFont, titleTextColor: titleTextColor)
    }
    
    func segmentioIndicatorOptions() -> SegmentioIndicatorOptions {
        return SegmentioIndicatorOptions(type: .bottom, ratio: 1, height: 5, color: UIColor.tint())
    }
    
    func segmentioHorizontalSeparatorOptions() -> SegmentioHorizontalSeparatorOptions {
        return SegmentioHorizontalSeparatorOptions(type: .bottom, height: 1, color: UIColor.lightGray)
    }
    
    func segmentioVerticalSeparatorOptions() -> SegmentioVerticalSeparatorOptions {
        return SegmentioVerticalSeparatorOptions(ratio: 1, color: UIColor.lightGray)
    }
}
