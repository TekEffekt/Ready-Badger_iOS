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
    
    // Stuff said local html file into the webview (called when the view is awoken - see awakeFromNib())
    func loadAddressURL(){
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        
        let urlpath = Bundle.main.path(forResource: "aboutUs", ofType: "html");
        let requesturl = URL(string: urlpath!)
        let request = URLRequest(url: requesturl!)
        webView.loadRequest(request)
    }
}
