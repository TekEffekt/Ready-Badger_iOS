//
//  AboutUsViewController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 12/7/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController, MenuItem, DefaultTheme {

    @IBOutlet weak var webView: UIWebView!
    var menu: HamburgerMenu?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        let urlPath = NSString(string: Bundle.main.path(forResource: "aboutUs", ofType: "html")!)
        let escapedString = urlPath.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        let requesturl = URL(string: escapedString!)
        let request = URLRequest(url: requesturl!)
        webView.loadRequest(request)
    }
    
}
