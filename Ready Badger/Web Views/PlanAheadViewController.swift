//
//  PlanAheadViewController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/22/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class PlanAheadViewController: UIViewController, MenuItem, DefaultTheme {

    var menu: HamburgerMenu?
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a url request to the 'get kit' page on the website
        let url = NSURL (string: "http://ready.wi.gov/Plan/Plan.asp")
        let requestObj = NSURLRequest(url: url! as URL)
        
        // Scale page to fit screen, allow user to scroll and zoom
        webView.scalesPageToFit = true
        
        // Load the request into the web view
        webView.loadRequest(requestObj as URLRequest)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
    }

}
